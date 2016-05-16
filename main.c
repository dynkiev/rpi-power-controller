#include <avr/io.h>
#include <util/delay.h>
 
int main(void)
{
    //PB3 - output to raspberry reset
    //PB4 - input from raspberry GPIO
    PORTB |= (1<<PB4);
 
    _delay_ms(4*1000);    //initial delay for boot

    int prev_pin_status = 0; 
    int curr_pin_status = 0;
    int check_count = 0;
    while (1) {
       curr_pin_status = (PINB & (1<<PB4));
       if (curr_pin_status == prev_pin_status) {
          _delay_ms(100);
          check_count+=1;
       }
       else {
          check_count = 0;
          prev_pin_status = curr_pin_status;
          _delay_ms(100);
       }
       if (check_count > 50) {    //watchdow time, *0,1 ms
         //reset
         DDRB  |= (1<<PB3);
         _delay_ms(500);         //reset pulse width
         DDRB  &= ~(1<<PB3);
         //prepare for initial status
         check_count=0;
         _delay_ms(4*1000);   //initial delay to boot
       }

    }
 
    return 0;
}
