library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity display is
  Port (dataa: in std_logic_vector(31 downto 0);
        clkk: in std_logic;
        catodd: out std_logic_vector(7 downto 0);
        anodd: out std_logic_vector(7 downto 0) );
end display;

architecture Behavioral of display is
begin
  process(clkk)
    variable cnt: integer:=0; --nr cati anozi sunt activi
    variable anod_tmp: std_logic_vector(7 downto 0);
    type numar is array(0 to 3) of std_logic_vector(7 downto 0);
    variable cif: numar; --aici se imparte intrarea dataa
    variable speed: integer:=0; --pt incetinirea afisajelor
  begin 
    if rising_edge(clkk) then 
      if speed=50000 then 
        speed:=0;
        cif(3):=dataa(31 downto 24); 
        cif(2):=dataa(23 downto 16); 
        cif(1):=dataa(15 downto 8);
        cif(0):=dataa(7 downto 0);
        anod_tmp:=(others=>'1'); 
        anod_tmp(cnt):='0';
        anodd<=anod_tmp;
        catodd<=cif(cnt);
        cnt:=cnt+1;
        if cnt>3 then 
          cnt:=0;
        end if; 
      else 
        speed:=speed+1;
      end if; 
    end if;
  end process;

end Behavioral;
