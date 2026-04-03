library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity seven_segment is
  Port (nrr: in std_logic_vector(3 downto 0); --de la 0 la 15
        segmm: out std_logic_vector(7 downto 0)); --nr codificat pt a fi afisat in hexa
end seven_segment;

architecture Behavioral of seven_segment is
signal tmp: std_logic_vector(7 downto 0):=(others=>'0');
begin
  proc_nr: process(nrr)
  begin
    case nrr is --ies pe 8 biti e transformarea nr in hexa
      when "0000"=> tmp<="11000000"; --cif 0
      when "0001"=> tmp<="11111001"; --1
	  when "0010"=> tmp<="10100100"; --2
	  when "0011"=> tmp<="10110000"; --3
	  when "0100"=> tmp<="10011001"; --4
	  when "0101"=> tmp<="10010010"; --5
	  when "0110"=> tmp<="10000010"; --6
	  when "0111"=> tmp<="11111000"; --7
	  when "1000"=> tmp<="10000000"; --8
	  when "1001"=> tmp<="10010000"; --9
	  when "1010"=> tmp<="10001000"; --A
	  when "1011"=> tmp<="10000011"; --b mic, altfel nu merge reprez
	  when "1100"=> tmp<="11000110"; --C
	  when "1101"=> tmp<="10100001"; --d mic
	  when "1110"=> tmp<="10000110"; --E
	  when "1111"=> tmp<="10001110"; --F
	  when others=> tmp<="11111111"; 
	end case;
  end process;
segmm<=tmp;
end Behavioral;
