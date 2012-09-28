#include <reg51.h>

sbit move_disable = P3^5;
sbit dir_disable = P3^3;

sbit is_forward = P3^4;		
sbit is_right = P3^2;

char ch;

int main()
{
	
	is_forward = 0;
	is_right = 0;
	move_disable = 1;
	dir_disable = 1;

	SCON = 0x50;
	TMOD |= 0x20;
	PCON |= 0x80;
	TL1 = 0xFD; //9600 = FD, 2400 = F4
	TH1 = 0xFD;
	IE |= 0x90;
	TR1 = 1;
	TI = 1;
			  /*
						is_forward = 1;
					is_right = 1;
					move_disable = 0;
					dir_disable = 0;
					*/
	
	while (1)
	{
	//   /*
		if (RI)
		{
			RI=0;
			ch = SBUF;
			TI=1;
			switch(ch)
			{
			/*
				case 0x01:
					is_forward = 0;
					is_right = 0;
					move_disable = 0;
					dir_disable = 0;
					TI=0;
					break;
				case 0x02:
					is_forward = 1;
					is_right = 1;
					move_disable = 0;
					dir_disable = 0;
					TI=0;
					break;
				case 0x03:
					is_forward = 0;
					is_right = 0;
					move_disable = 1;
					dir_disable = 0;
					TI=0;
					break;
				case 0x04:
					is_forward = 0;
					is_right = 0;
					move_disable = 0;
					dir_disable = 1;
					TI=0;
					break;
				case 0x05:
					is_forward = 1;
					is_right = 0;
					move_disable = 0;
					dir_disable = 0;
					TI=0;
					break;
				case 0x06:
					is_forward = 0;
					is_right = 1;
					move_disable = 0;
					dir_disable = 0;
					TI=0;
					break;
				*/

                //forward
				case 0x01:
					move_disable = 0;
                    is_forward = 1;
					TI = 0;
					break;
                //backward
				case 0x02:
					move_disable = 0;
                    is_forward = 0;
					TI = 0;
					break;
                //left
				case 0x03:
					dir_disable = 0;
                    is_right = 0;
					TI = 0;
					break;
                //right
				case 0x04:
					dir_disable = 0;
                    is_right = 1;
					TI = 0;
					break;
                //disable direction
				case 0x05:
					dir_disable = 1;
					TI = 0;
					break;
                //stop & disable direction
				case 0x00:
					is_forward = 0;
					is_right = 0;
					move_disable = 1;
					dir_disable = 1;
					TI=0;
					break;
				default:
				/*
					is_forward = ~is_forward;
					is_right = ~is_right;
					TI = 0;
					*/
					
					break;
			}
		}
	//	*/
	}

	return 0;
}
