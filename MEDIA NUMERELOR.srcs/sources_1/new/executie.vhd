library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity executie is
  Port (clk: in std_logic;
        rst_date: in std_logic;
        rst_medie: in std_logic; 
        sel_mod: in std_logic_vector(2 downto 0);
        lungime: in std_logic_vector(2 downto 0);
        catod: out std_logic_vector(7 downto 0);
        anod: out std_logic_vector(7 downto 0));
end executie;

architecture Behavioral of executie is
component generator
  Port (sel_modd: in std_logic_vector(2 downto 0);
        clk_datee: in std_logic;
        rst_datee: in std_logic;
        nrr: out std_logic_vector (7 downto 0) );
end component;
component media
  Port (nrr: in std_logic_vector(7 downto 0);
	   clk_datee: in std_logic;                      
	   lungimee: in std_logic_vector(2 downto 0);
	   rst_mediee: in std_logic;                          
	   ultimm: out std_logic_vector(7 downto 0);
	   mediee: out std_logic_vector(7 downto 0));
end component;
component divizor_frecv
  Port (clkk: in std_logic;
        rst_datee: in std_logic; 
        sel_modd: in std_logic_vector(2 downto 0);
        clk_datee: out std_logic:='0');
end component;
component seven_segment
  Port (nrr: in std_logic_vector(3 downto 0); --de la 0 la 15
        segmm: out std_logic_vector(7 downto 0)); 
end component;
component display 
  Port (dataa: in std_logic_vector(31 downto 0);
        clkk: in std_logic;
        catodd: out std_logic_vector(7 downto 0);
        anodd: out std_logic_vector(7 downto 0) );
end component;
signal clk_date: std_logic:='0'; 
signal ultim: std_logic_vector(7 downto 0):=(others =>'0');
signal nr: std_logic_vector(7 downto 0):=(others =>'0');
signal medie: std_logic_vector(7 downto 0):=(others =>'0');
signal data: std_logic_vector(31 downto 0);
type nr4 is array(3 downto 0) of std_logic_vector(3 downto 0);
type nr8 is array(3 downto 0) of std_logic_vector(7 downto 0); 
signal n4: nr4:=(others =>(others =>'0'));
signal n8: nr8:=(others =>(others =>'0'));
begin
  gen: generator port map(sel_modd=>sel_mod, clk_datee=>clk_date, rst_datee=>rst_date, nrr=>nr);
  med_nr: media port map(nrr=>nr, clk_datee=>clk_date, lungimee=>lungime, rst_mediee=>rst_medie, ultimm=>ultim, mediee=>medie); 
  df: divizor_frecv port map(clkk=>clk, rst_datee=>rst_date, sel_modd=>sel_mod, clk_datee=>clk_date);
  n4(0)<=ultim(3 downto 0);
  seg1: seven_segment port map(nrr=>n4(0), segmm=>n8(0));
  n4(1)<=ultim(7 downto 4);
  seg2: seven_segment port map(nrr=>n4(1), segmm=>n8(1));
  n4(2)<=medie(3 downto 0);
  seg3: seven_segment port map(nrr=>n4(2), segmm=>n8(2));
  n4(3)<=medie(7 downto 4);
  seg4: seven_segment port map(nrr=>n4(3), segmm=>n8(3));
  data(7 downto 0)<=n8(0); --ultimul nr generat, cif unitati
  data(15 downto 8)<=n8(1); --ult nr gen, cif zeci
  data(23 downto 16)<=n8(2); --media, cif unitati
  data(31 downto 24)<=n8(3); --media
  afisare: display port map(dataa=>data, clkk=>clk, catodd=>catod, anodd=>anod);
  
end Behavioral;
