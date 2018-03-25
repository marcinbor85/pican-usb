#include "slcan.h"

static uint8_t decode_nibble(uint8_t **buf)
{
	uint8_t b;
	if ((**buf >= '0') && (**buf <= '9')) {
		b = (uint8_t)(**buf - (uint8_t)'0');
	} else if ((**buf >= 'a') && (**buf <= 'f')) {
		b = (uint8_t)(**buf - (uint8_t)'a' + 10);
	} else if ((**buf >= 'A') && (**buf <= 'F')) {
		b = (uint8_t)(**buf - (uint8_t)'A' + 10);
	}
	b &= 0x0F;
	(*buf)++;
	return b;
}

static uint8_t decode_byte(uint8_t **buf)
{
	uint8_t b;
	b = (uint8_t)((uint8_t)decode_nibble(buf) << 4);
	b |= (uint8_t)((uint8_t)decode_nibble(buf));
	return b;
}

static uint32_t decode_sid(uint8_t **buf)
{
	uint32_t id;
	id = (uint32_t)((uint32_t)(decode_nibble(buf) & 0x07) << 8);
	id |= (uint32_t)((uint32_t)decode_nibble(buf) << 4);
	id |= (uint32_t)((uint32_t)decode_nibble(buf));
	return id;
}

static uint32_t decode_eid(uint8_t **buf)
{
	uint32_t id;
	id = (uint32_t)((uint32_t)(decode_nibble(buf) & 0x01) << 28);
	id |= (uint32_t)((uint32_t)decode_nibble(buf) << 24);
	id |= (uint32_t)((uint32_t)decode_nibble(buf) << 20);
	id |= (uint32_t)((uint32_t)decode_nibble(buf) << 16);
	id |= (uint32_t)((uint32_t)decode_nibble(buf) << 12);
	id |= (uint32_t)((uint32_t)decode_nibble(buf) << 8);
	id |= (uint32_t)((uint32_t)decode_nibble(buf) << 4);
	id |= (uint32_t)((uint32_t)decode_nibble(buf));
	return id;
}

static void encode_nibble(uint8_t **buf, uint8_t b)
{
	b &= 0x0F;
	if (b < 10) {
		**buf = (uint8_t)('0' + b);
	} else {
		**buf = (uint8_t)((uint8_t)'A' + (uint8_t)(b - 10));
	}
	(*buf)++;
}

static void encode_byte(uint8_t **buf, uint8_t b)
{
	encode_nibble(buf, (uint8_t)(b >> 4));
	encode_nibble(buf, b);
}

static void encode_sid(uint8_t **buf, uint32_t id)
{
	encode_nibble(buf, (id >> 8) & 0x07);
	encode_nibble(buf, id >> 4);
	encode_nibble(buf, id);
}

static void encode_eid(uint8_t **buf, uint32_t id)
{
	encode_nibble(buf, (id >> 28) & 0x01);
	encode_nibble(buf, id >> 24);
	encode_nibble(buf, id >> 20);
	encode_nibble(buf, id >> 16);
	encode_nibble(buf, id >> 12);
	encode_nibble(buf, id >> 8);
	encode_nibble(buf, id >> 4);
	encode_nibble(buf, id);
}

void slcan_init(struct slcan_object *slcan, const struct slcan_interface *iface)
{
	slcan->iface = iface;
	slcan->size = 0;
	slcan->baudrate = SLCAN_BAUDRATE_6;
}

void slcan_send_frame(struct slcan_object *slcan, struct can_frame *frame)
{
	uint8_t buf[SLCAN_BUFFER_SIZE];
	uint8_t *out = buf;
	uint8_t i;
	
	if (frame->remote != 0) {
		if (frame->extended != 0) {
			*out = 'R';
			out++;
			encode_eid(&out, frame->id);
		} else {
			*out = 'r';
			out++;
			encode_sid(&out, frame->id);
		}
		encode_nibble(&out, frame->dlc);
	} else {
		if (frame->extended != 0) {
			*out = 'T';
			out++;
			encode_eid(&out, frame->id);
		} else {
			*out = 't';
			out++;
			encode_sid(&out, frame->id);
		}
		encode_nibble(&out, frame->dlc);
		for (i = 0; i < frame->dlc; i++)
			encode_byte(&out, frame->data[i]);
	}
	*out = SLCAN_END_LINE_BYTE;
	out++;
	*out = 0x00;
	out++;
	
	out = buf;
	while (*out != 0) {
		slcan->iface->send_byte(*out);
		out++;
	}
}

static uint8_t parse_frame(struct slcan_object *slcan)
{
	struct can_frame frame;
	uint8_t *in;
	uint8_t i;

	if (slcan->buf[0] == 't') {
		if (slcan->size < 5)
			return 1;

		frame.remote = 0;
		frame.extended = 0;

		in = &slcan->buf[1];
		frame.id = decode_sid(&in);
		frame.dlc = decode_nibble(&in);
		if (frame.dlc > 8)
			return 1;

		if (slcan->size < (5 + (frame.dlc * 2)))
			return 1;

		for (i = 0; i < frame.dlc; i++)
			frame.data[i] = decode_byte(&in);

		return slcan->iface->recv_frame(&frame);
	} else if (slcan->buf[0] == 'T') {
		if (slcan->size < 10)
			return 1;

		frame.remote = 0;
		frame.extended = 1;

		in = &slcan->buf[1];
		frame.id = decode_eid(&in);
		frame.dlc = decode_nibble(&in);
		if (frame.dlc > 8)
			return 1;

		if (slcan->size < (10 + (frame.dlc * 2)))
			return 1;

		for (i = 0; i < frame.dlc; i++)
			frame.data[i] = decode_byte(&in);

		return slcan->iface->recv_frame(&frame);
	} else if (slcan->buf[0] == 'r') {
		if (slcan->size < 5)
			return 1;

		frame.remote = 1;
		frame.extended = 0;

		in = &slcan->buf[1];
		frame.id = decode_sid(&in);
		frame.dlc = decode_nibble(&in);
		if (frame.dlc > 8)
			return 1;

		return slcan->iface->recv_frame(&frame);
	} else if (slcan->buf[0] == 'R') {
		if (slcan->size < 10)
			return 1;

		frame.remote = 1;
		frame.extended = 1;

		in = &slcan->buf[1];
		frame.id = decode_eid(&in);
		frame.dlc = decode_nibble(&in);
		if (frame.dlc > 8)
			return 1;

		return slcan->iface->recv_frame(&frame);
	}

	return 1;
}

void slcan_parse(struct slcan_object *slcan, uint8_t b)
{
	int8_t status = 0;
	uint8_t buf[2];
	uint8_t *ptr;
	
	if (b != SLCAN_END_LINE_BYTE) {
		slcan->buf[slcan->size] = b;
		if (++slcan->size >= SLCAN_BUFFER_SIZE)
			status = -1;
		goto slcan_parse_end;
	}
	
	if (slcan->size == 0) {
		status = -1;
		goto slcan_parse_end;
	}
	
	switch (slcan->buf[0]) {
	case 'C':
		if (slcan->iface->close() == 0) {
			status = 1;
		} else {
			status = -1;
		}
		break;
	case 'O':
		if (slcan->iface->open(slcan->baudrate, SLCAN_MODE_NORMAL) == 0) {
			status = 1;
		} else {
			status = -1;
		}
		break;
	case 'L':
		if (slcan->iface->open(slcan->baudrate, SLCAN_MODE_LISTEN) == 0) {
			status = 1;
		} else {
			status = -1;
		}
		break;
	case 'l':
		if (slcan->iface->open(slcan->baudrate, SLCAN_MODE_LOOPBACK) == 0) {
			status = 1;
		} else {
			status = -1;
		}
		break;
	case 'S':
		if (slcan->size < 2) {
			status = -1;
			break;
		}

		status = 1;
		switch (slcan->buf[1]) {
		case '0':
			slcan->baudrate = SLCAN_BAUDRATE_0;
			break;
		case '1':
			slcan->baudrate = SLCAN_BAUDRATE_1;
			break;
		case '2':
			slcan->baudrate = SLCAN_BAUDRATE_2;
			break;
		case '3':
			slcan->baudrate = SLCAN_BAUDRATE_3;
			break;
		case '4':
			slcan->baudrate = SLCAN_BAUDRATE_4;
			break;
		case '5':
			slcan->baudrate = SLCAN_BAUDRATE_5;
			break;
		case '6':
			slcan->baudrate = SLCAN_BAUDRATE_6;
			break;
		case '7':
			slcan->baudrate = SLCAN_BAUDRATE_7;
			break;
		case '8':
			slcan->baudrate = SLCAN_BAUDRATE_8;
			break;
		default:
			status = -1;;
			break;			
		}
		break;
	case 'V':
		slcan->iface->send_byte('V');
		ptr = slcan->iface->hardware_version;
		while (*ptr != 0) {
			slcan->iface->send_byte(*ptr);
			ptr++;
		}
		status = 1;
		break;
	case 'v':
		slcan->iface->send_byte('v');
		ptr = slcan->iface->firmware_version;
		while (*ptr != 0) {
			slcan->iface->send_byte(*ptr);
			ptr++;
		}
		status = 1;
		break;
	case 'N':
		slcan->iface->send_byte('N');
		ptr = slcan->iface->unique_serial;
		while (*ptr != 0) {
			slcan->iface->send_byte(*ptr);
			ptr++;
		}
		status = 1;
		break;
	case 'F':
		slcan->iface->send_byte('F');
		ptr = buf;
		encode_byte(&ptr, slcan->iface->get_status());
		slcan->iface->send_byte(buf[0]);
		slcan->iface->send_byte(buf[1]);
		status = 1;
		break;
	case 't':
	case 'T':
	case 'r':
	case 'R':
		if (parse_frame(slcan) == 0) {
			status = 0;
		} else {
			status = -1;
		}
		break;
	default:
		status = -1;
		break;
	}
	
	slcan->size = 0;

slcan_parse_end:
	if (status > 0) {
		slcan->size = 0;
		slcan->iface->send_byte(SLCAN_END_LINE_BYTE);
	} else if (status < 0) {
		slcan->size = 0;
		slcan->iface->send_byte(SLCAN_ERROR_BYTE);
	}
}