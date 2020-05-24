library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity bcd_counter is
	port(
		signal Clk			: in std_logic;
		signal Direction	: in std_logic;
		signal Init			: in std_logic;
		signal Enable		: in std_logic;
		signal Q_out		: out unsigned(3 downto 0)
		);		
end bcd_counter;

architecture behavioral of bcd_counter is

signal counter : unsigned(3 downto 0) := "0000";

begin 

	process (Clk)
	begin
		if (rising_edge(Clk)) then
			if (Init = '1') then
				case Direction is 
					when '0' =>			-- Up counter Reset
						counter <= "0000";
					when '1' =>			-- Down counter Reset	
						counter <= "1001";
					when Others =>
						counter <= "0000";			
				end case;			
			elsif (Enable = '0') then
				case Direction is 
					when '0' =>			-- Up counter running
						if (counter = "1001") then
							counter <=  "0000";
						else 
							counter <= counter + 1;
						end if;
					when '1' =>			-- Down counter running
						if (counter = "0000") then
							counter <=  "1001";
						else
							counter <= counter - 1;
						end if;
					when Others =>
									
				end case;		
			end if;		
		end if;
	end process;
	
	Q_Out <= counter;

end behavioral;
