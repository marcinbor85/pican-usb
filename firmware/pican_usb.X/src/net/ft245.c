/*
The MIT License (MIT)

Copyright (c) 2017 Marcin Borowicz <marcinbor85@gmail.com>

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

#include "ft245.h"

#include <stddef.h>
#include <assert.h>

void ft245_init(const struct ft245_interface *iface)
{
        assert(iface != NULL);
        
        assert(iface->config_port_input != NULL);
        assert(iface->config_port_output != NULL);
        assert(iface->get_port != NULL);
        assert(iface->init != NULL);
        assert(iface->is_rx_full != NULL);
        assert(iface->is_tx_empty != NULL);
        assert(iface->set_port != NULL);
        assert(iface->set_read != NULL);
        assert(iface->set_write != NULL);
        
        iface->init();
        iface->config_port_input();
        iface->set_read(1);
        iface->set_write(0);        
}

uint8_t ft245_get_byte(const struct ft245_interface *iface, uint8_t *byte)
{
        assert(iface != NULL);
        assert(byte != NULL);
        
        if (iface->is_rx_full() == 0)
                return 0;
        
        iface->config_port_input();
        iface->set_read(0);   
        *byte = iface->get_port();
        iface->set_read(1);
        
        return 1;
}

uint8_t ft245_put_byte(const struct ft245_interface *iface, uint8_t byte)
{
        assert(iface != NULL);
        
        if (iface->is_tx_empty() == 0)
                return 0;
        
        iface->set_write(1);   
        iface->config_port_output();
        iface->set_port(byte);
        iface->set_write(0);   
        iface->config_port_input();   
        
        return 1;
}