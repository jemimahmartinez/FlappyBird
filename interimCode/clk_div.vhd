library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity clk_div is
  port (Clk : in std_logic;
      Clk_1s : out std_logic);
end entity clk_div;

architecture behaviour of clk_div is
  signal count: integer := 0;
  signal temp : std_logic := '0';
  begin
    process(clk)
      begin
        if (rising_edge(clk)) then
          count <= count + 1;
          if (count = 499999) then --499999
            temp <= NOT temp;
            count <= 0;
          end if;
        end if;
        
    end process;  
    Clk_1s <= temp;  
end architecture behaviour;