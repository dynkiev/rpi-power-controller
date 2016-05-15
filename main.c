#include <avr/io.h>
#include <util/delay.h>
 
int main(void)
{
//    const int msDelay = 1000;
 
    // PortB pin4 to output (set bit to 1 using SHL)
    //DDRB = 1<<DDB4;
    DDRB  |= (1<<PB4);
 
    // PortB to low
    PORTB |= (1<<PB3);
 
    while (1) {
        // XOR on pin 4
	if (PINB & (1<<PB3)){
        	//PORTB ^= 1<<PB4;
                PORTB |= (1<<PB4);
               // _delay_ms(200);
       	}
        else {
           PORTB &= ~(1<<PB4);
         }
	//_delay_ms(msDelay);

    }
 
    return 0;
}
