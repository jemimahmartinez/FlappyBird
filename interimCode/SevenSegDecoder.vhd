library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity SevenSegDecoder is
  port(input : in std_logic_vector(3 downto 0);
    output : out std_logic_vector(6 downto 0));
end entity SevenSegDecoder;

architecture behaviour of SevenSegDecoder is
  begin
    with input select output <=
      "1000000" when "0000", --0                1111110    0000001
      "1111001" when "0001", --1    ----0----   0110000    1001111
      "0100100" when "0010", --2    |       |   1101101    0010010
      "0110000" when "0011", --3    5       1   1111001    0000110
      "0011001" when "0100", --4    |       |   0110011    1001100 
      "0010010" when "0101", --5    ----6----   1011011    0100100
      "0000010" when "0110", --6    |       |   1011111    0100000
      "1111000" when "0111", --7    4       2   1110000    0001111
      "0000000" when "1000", --8    |       |   1111111    0000000
      "0010000" when "1001", --9    ----3----   1111011    0000100
      "1111111" when others; --empty            0000000
      
end architecture behaviour;