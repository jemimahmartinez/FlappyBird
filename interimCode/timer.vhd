library IEEE;
use IEEE.std_logic_1164.all;

entity timer is
    port (Clk, Start, reset : in std_logic;
          ones_leds, tens_leds : out std_logic_vector(6 downto 0));
end entity timer;

architecture Structural of timer is
  
  ------------ Components ------------
  
  -- Clock Divider --
  component clk_div is
    port (Clk : in std_logic;
          Clk_1s : out std_logic);
  end component clk_div;
  
  -- BCD Counter --
  component bcd_counter is
    port (Clk, Direction, Init, Enable : in std_logic;
          Q_Out : out std_logic_vector(3 downto 0));
  end component bcd_counter;
  
  -- Seven Segment Decoder --
  component SevenSegDecoder is 
    port (bcd : in std_logic_vector(3 downto 0);
          leds : out std_logic_vector(7 downto 0));
  end component SevenSegDecoder;
  
  signal clk1s, tens_enable: std_logic;
  signal Q_Ones, Q_Tens: std_logic_vector(3 downto 0);
  
begin
  ------------ Port Maps  -----------    
  
  -- Clock Divider --
  div_clk: clk_div
    port map (Clk => Clk, Clk_1s => clk1s);
  
  -- BCD Counters --
  ones_counter: bcd_counter
    port map (Clk => clk1s, Init => reset, Direction => '0', Enable => Start, Q_Out => Q_Ones);
  tens_counter: bcd_counter
    port map (Clk => clk1s, Init => reset, Direction => '0', Enable => tens_enable, Q_Out => Q_Tens);
  
  -- Seven Segment Decoders --
  ones_seg7: SevenSegDecoder
    port map (bcd => Q_Ones, leds => ones_leds);
  tens_seg7: SevenSegDecoder
    port map (bcd => Q_Tens, leds => tens_leds);
    
  ------------- Enables ------------
    
  tens_enable <= '0' when ((Start = '0') and (Q_Ones = "1111")) else
                 '1';   


end architecture Structural;