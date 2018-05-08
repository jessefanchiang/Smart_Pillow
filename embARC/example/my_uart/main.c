/* ------------------------------------------
 * Copyright (c) 2016, Synopsys, Inc. All rights reserved.

 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:

 * 1) Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.

 * 2) Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation and/or
 * other materials provided with the distribution.

 * 3) Neither the name of the Synopsys, Inc., nor the names of its contributors may
 * be used to endorse or promote products derived from this software without
 * specific prior written permission.

 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * \version
 * \date
 * \author
--------------------------------------------- */

/**
 * \defgroup	EMBARC_APP_TMPL		embARC Template Example
 * \ingroup	EMBARC_APPS_TOTAL
 * \ingroup	EMBARC_APPS_BOARD_EMSK
 * \ingroup	EMBARC_APPS_BAREMETAL
 * \brief	embARC Example for template
 *
 * \details
 * ### Extra Required Tools
 *
 * ### Extra Required Peripherals
 *
 * ### Design Concept
 *
 * ### Usage Manual
 *
 * ### Extra Comments
 *
 */

/**
 * \file
 * \ingroup	EMBARC_APP_TMPL
 * \brief	main source of template example
 */

/**
 * \addtogroup	EMBARC_APP_TMPL
 * @{
 */
/* embARC HAL */
#include "embARC.h"
#include "embARC_debug.h"
#include <stdio.h>

static DEV_UART *uart;

void my_emsk_uart_init(void);

// Tx : Pmod1 Pin 3 (J1)
// Rx : Pmod1 Pin 4 (J1)

/** main entry */
int main(void)
{
	my_emsk_uart_init();
	int count = 0;
	char message[4];
	while(1)
	{
		my_emsk_uart_init();
		uart->uart_write("\x1b[j", 3);
		uart->uart_write("Value=", 6);
		sprintf(message, "%4d", count);
		uart->uart_write(message, 4);
		count++;
		board_delay_ms(100, 1);
	}
	return E_SYS;
}

/** emsk on-board uart init */
void my_emsk_uart_init(void)
{
	uart = uart_get_dev(DW_UART_0_ID);

	uart->uart_open(UART_BAUDRATE_9600);

error_exit:
	return;
}
/** @} */