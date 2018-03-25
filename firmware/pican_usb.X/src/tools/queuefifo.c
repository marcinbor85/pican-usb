/*
The MIT License (MIT)

Copyright (c) 2016 Marcin Borowicz <marcinbor85@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
 */

#include "queuefifo.h"

#include <string.h>

static uint8_t put(void *self, void *item)
{
	struct queuefifo_object *fifo = self;
	struct queue_object *queue = &fifo->queue;

	memcpy(&((uint8_t*) queue->buf)[fifo->tail * queue->item_size], (uint8_t*) item, queue->item_size);

	if (++fifo->tail >= queue->capacity)
		fifo->tail = 0;

	if (++queue->count > queue->capacity) {
		queue->count = queue->capacity;
		if (++fifo->head >= queue->capacity)
			fifo->head = 0;
		return 0;
	}
	return 1;
}

static uint8_t get(void *self, void *item)
{
	struct queuefifo_object *fifo = self;
	struct queue_object *queue = &fifo->queue;

	if (queue->count == 0)
		return 0;

	memcpy((uint8_t*) item, &((uint8_t*) queue->buf)[fifo->head * queue->item_size], queue->item_size);

	if (++fifo->head >= queue->capacity)
		fifo->head = 0;
	queue->count--;

	return 1;
}

void queuefifo_init(void *self, void *buf, uint32_t capacity, uint32_t item_size)
{
	struct queuefifo_object *fifo = self;
	struct queue_object *queue = &fifo->queue;

	queue_init(queue, buf, capacity, item_size);
	
	fifo->tail = 0;
	fifo->head = 0;
	queue->put = put;
	queue->get = get;
}
