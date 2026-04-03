library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity divizor_frecv is --reduc la 1Hz, o perioada de o sec
  Port (clkk: in std_logic;
        rst_datee: in std_logic; 
        sel_modd: in std_logic_vector(2 downto 0);
        clk_datee: out std_logic:='0');
end divizor_frecv;

architecture Behavioral of divizor_frecv is

signal cnt1: unsigned(25 downto 0):=(others=>'0'); --numarator pt 50 mil
signal clk_out1: std_logic:='0';
signal cnt25: unsigned(25 downto 0):=(others=>'0'); 
signal clk_out25: std_logic:='0';
begin
  clock_proc: process(clkk)
  begin 
    if rising_edge(clkk) then
      if rst_datee='1' then 
        cnt1<=(others=>'0');
        clk_out1<='0';
        cnt25<=(others=>'0');
        clk_out25<='0';
      else
        if sel_modd="001" then 
          if cnt25=199999999 then 
            cnt25<=(others=>'0'); 
            clk_out25<=not clk_out25;
          else 
            cnt25<=cnt25+1;
          end if;
        else
          if cnt1=49999999 then --de la 0 la 49 mil sunt 50 mil cicluri
            cnt1<=(others=>'0'); --daca am ajuns la 499.. il resetam
            clk_out1<=not clk_out1;
          else 
            cnt1<=cnt1+1; --altfel cont sa nr 
          end if; 
       end if;
     end if; 
   end if;
  end process clock_proc;
clk_datee<=clk_out25 when sel_modd="001" else clk_out1;

end Behavioral;
