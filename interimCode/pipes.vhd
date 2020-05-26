LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

LIBRARY altera_mf;
USE altera_mf.all;

ENTITY pipes IS --RanGen 				: IN ;
	PORT
	(
		SIGNAL Clk, hor_sync 	: IN std_logic;
		SIGNAL pixel_row, pixel_column		: IN std_logic_vector(9 DOWNTO 0);
		SIGNAL red, green, blue 	: OUT std_logic
	);
END pipes;

architecture behavior of pipes is

SIGNAL pipe_on					: std_logic;
SIGNAL size_x, size_y 		: std_logic_vector(9 DOWNTO 0);  
SIGNAL pipe_y_pos				: std_logic_vector(9 DOWNTO 0);
SIGNAL pipe_x_pos				: std_logic_vector(10 DOWNTO 0);
SIGNAL pipe_x_motion			: std_logic_vector(10 DOWNTO 0);

BEGIN           

size_y <= CONV_STD_LOGIC_VECTOR(479,10);
size_x <= CONV_STD_LOGIC_VECTOR(20,10);
pipe_y_pos <= CONV_STD_LOGIC_VECTOR(240,10);
--pipe_x_pos <= CONV_STD_LOGIC_VECTOR(30,11);


pipe_on <= 	'1' when ('0' & pipe_x_pos <= pixel_column + size_x) and ('0' & pixel_column <= pipe_x_pos + size_x)
				and ('0' & pipe_y_pos <= pixel_row + size_y) and ('0' & pixel_row <= pipe_y_pos + size_y)   else	
				'0';

-- Colours for pixel data on video signal
-- Changing the background and ball colour by pushbuttons
Red 	<= not pipe_on;
Green <= pipe_on;
Blue 	<= not pipe_on;

--Move_Pipe: process (hor_sync)  	
--begin
--
--	if(rising_edge(hor_sync))then 
--		pipe_x_motion <= CONV_STD_LOGIC_VECTOR(1,11);
--	end if;
--	
--	pipe_x_pos <= pipe_x_pos + pipe_x_motion;
--	
--end process Move_Pipe;

end behavior;
