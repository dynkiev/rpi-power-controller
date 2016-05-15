#include <avr/io.h>
#include <util/delay.h>
 
int main(void)
{
    //PB3 - output to raspberry reset
    //PB4 - input from raspberry GPIO
    DDRB  |= (1<<PB3);
    PORTB |= (1<<PB4) | (1<<PB3);
 
    _delay_ms(4*1000);
 
    int check_count = 0;
    while (1) {
       //if button pressed
       if ((PINB & (1<<PB4)) == 0) {
          check_count = 0;
          _delay_ms(100);
       }
       else {
         check_count++;
         _delay_ms(100);
       };
       if (check_count > 50) {
         //reset
         PORTB &= ~(1<<PB3);
         _delay_ms(500);
         PORTB |= (1<<PB3);
         //prepare for initial status
         check_count=0;
         _delay_ms(4*1000);
       }

    }
 
    return 0;
}
