LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY bouncy_ball IS
	PORT
		(SIGNAL pb1, pb2, clk, vert_sync, left_button, ds0	: IN std_logic;
        SIGNAL pixel_row, pixel_column		: IN std_logic_vector(9 DOWNTO 0);
		SIGNAL red, green, blue 			: OUT std_logic);		--ground, reset 
END bouncy_ball;

architecture behavior of bouncy_ball is

SIGNAL ball_on					: std_logic; --gnd,rst
SIGNAL size 					: std_logic_vector(9 DOWNTO 0);  
SIGNAL ball_y_pos				: std_logic_vector(9 DOWNTO 0);
SIGNAL ball_x_pos				: std_logic_vector(10 DOWNTO 0);
SIGNAL ball_y_motion			: std_logic_vector(9 DOWNTO 0);

BEGIN           

size <= CONV_STD_LOGIC_VECTOR(8,10);
-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball
ball_x_pos <= CONV_STD_LOGIC_VECTOR(150,11); --590
--ball_y_pos <= CONV_STD_LOGIC_VECTOR(350,10); --350
 
ball_on <= '1' when ( ('0' & ball_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & ball_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & ball_y_pos <= pixel_row + size) and ('0' & pixel_row <= ball_y_pos + size) )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';

-- Colours for pixel data on video signal
-- Changing the background and ball colour by pushbuttons
Red <= (not pb2) and (not ball_on) ;
Green <= not ball_on;
Blue <= pb1 ;


Move_Ball: process (vert_sync, left_button)  	
begin
	-- Move ball once every vertical sync
	if (rising_edge(vert_sync)) then		
		-- Bounce off top or bottom of the screen
		if ( ('0' & ball_y_pos >= CONV_STD_LOGIC_VECTOR(479,10) - size) or left_button = '1') then
--			ball_y_motion <= - CONV_STD_LOGIC_VECTOR(1,10);
			case ds0 is
				when '0' =>
					ball_y_motion <= - CONV_STD_LOGIC_VECTOR(1,10);
				when '1'=>
					ball_y_motion <= - CONV_STD_LOGIC_VECTOR(10,10);
				when others =>null;
			end case;
		--elsif (ball_y_pos <= size ) then 
			--ball_y_motion <= CONV_STD_LOGIC_VECTOR(2,10);
		elsif (left_button = '0') then
--			ball_y_motion <= CONV_STD_LOGIC_VECTOR(10,10);
			case ds0 is
				when '0' =>
					ball_y_motion <= CONV_STD_LOGIC_VECTOR(1,10);
				when '1'=>
					ball_y_motion <= CONV_STD_LOGIC_VECTOR(10,10);
				when others =>null;
			end case;
		end if;
		-- Compute next ball Y position
		ball_y_pos <= ball_y_pos + ball_y_motion;
	end if;
	
--	if (ball_y_pos == CONV_STD_LOGIC_VECTOR(479,10)) then
--		gnd <= '0';
--		rst <= '1';
--	else 
--		gnd <= '1';
--		rst <= '0';
--	end if;
--	ground <= gnd;
--	reset <= rst;
end process Move_Ball;

END behavior;

