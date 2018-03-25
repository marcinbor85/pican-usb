#include "can.h"

#include "tools/queuefifo.h"

static struct queuefifo_object rx_queue;
static struct queuefifo_object tx_queue;
static struct can_frame tx_buf[CAN_TX_QUEUE_SIZE];
static struct can_frame rx_buf[CAN_RX_QUEUE_SIZE];

static uint8_t sending_flag;

void can_deinit(void)
{
	can_disable_rx_isr();
	can_disable_tx_isr();
	
	sending_flag = 0;
	
	can_close();
}

void can_init(uint32_t baudrate, uint8_t mode)
{	
	queuefifo_init(&rx_queue, rx_buf, CAN_RX_QUEUE_SIZE, sizeof(struct can_frame));
	queuefifo_init(&tx_queue, tx_buf, CAN_TX_QUEUE_SIZE, sizeof(struct can_frame));	
	
	switch (mode) {
	case CAN_MODE_NORMAL:
		can_open_normal(baudrate);
		break;
	case CAN_MODE_LISTEN:
		can_open_listen(baudrate);
		break;
	case CAN_MODE_LOOPBACK:
		can_open_loopback(baudrate);
		break;
	}
	
	sending_flag = 0;
}

uint8_t can_recv(struct can_frame *frame)
{
	uint8_t ret;
	
	can_disable_rx_isr();
	ret = queue_get(&rx_queue, frame);
	can_enable_rx_isr();
	
	return ret;
}

void can_stop_tx(void)
{
	sending_flag = 0;
}

uint8_t can_send(struct can_frame *frame)
{
	uint8_t ret;
	
	can_disable_tx_isr();
	ret = queue_put(&tx_queue, frame);
	if ((sending_flag == 0) && (ret != 0)) {
		sending_flag = 1;
		can_start_tx();
	}
	can_enable_tx_isr();

	return ret;
}

uint8_t can_get_from_tx_queue(struct can_frame *frame)
{
	return queue_get(&tx_queue, frame);
}

uint8_t can_put_to_rx_queue(struct can_frame *frame)
{
	return queue_put(&rx_queue, frame);
}
