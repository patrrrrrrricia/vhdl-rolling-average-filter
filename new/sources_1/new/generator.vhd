library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity generator is
  Port (sel_modd: in std_logic_vector(2 downto 0);
        clk_datee: in std_logic;
        rst_datee: in std_logic;
        nrr: out std_logic_vector (7 downto 0) );
end generator;

architecture Behavioral of generator is
begin
  process(clk_datee)
  variable val4biti: std_logic_vector(3 downto 0):=("0101"); --5, val random
  variable val8biti: std_logic_vector(7 downto 0):=("00001000"); --8
  variable aux: std_logic_vector(7 downto 0):=(others=>'0');
  type student_data is array (5 downto 0) of std_logic_vector (7 downto 0);
  constant student1: student_data:=("00000111", "00000100", "00000011", "00000110", "00000000", "00001000");
  --secv student1: 7, 4, 3, 6, 0, 8
  constant student2: student_data:=("00001001", "00000001", "00000010", "00000110", "00000011","00000101"); 
  --secv student2: 9, 1, 2, 6, 3, 5
  variable s1: student_data:=student1; --ca sa le pot modifica
  variable s2: student_data:=student2;
  variable sq_wave: std_logic:='0'; --pt square 
  begin
     if(rising_edge(clk_datee)) then
       if(rst_datee='1') then --resetam la val initiale
         s1:=student1;
         s2:=student2;
         val4biti:=("0101");
         val8biti:=("00001000");
         sq_wave:='0';
         nrr<=(others=>'0');
      else
        case(sel_modd) is 
          when "000"=>nrr<=(others=>'0');
          
          when "001"=>
            if sq_wave='0' then 
              nrr<="00000000"; --alternez intre 0
              sq_wave:='1';
            else 
              nrr<="11111111"; --255 
              sq_wave:='0';
            end if;
        
          when "010"=> --secv1, rotim secv ca sa putem reveni la secv initiala dupa 6 cicluri
            aux:=s1(5);
            s1(5 downto 1):=s1(4 downto 0);
            s1(0):=aux;
            nrr(5 downto 0)<=s1(0)(5 downto 0); --nr din secv sunt pe 6 biti
            nrr(7 downto 6)<=(others =>'0'); --ceilalti 2 biti trb setati pe 0
          
          when "011"=> --secv2, la fel
            aux:=s2(5);
            s2(5 downto 1):=s2(4 downto 0);
            s2(0):=aux;
            nrr(5 downto 0)<=s2(0)(5 downto 0);
            nrr(7 downto 6)<=(others =>'0');
          
          when "110"=> --random intre 0-15
            nrr(3 downto 0)<=val4biti; --nr e pe 4 biti
            nrr(7 downto 4)<=(others=>'0'); --restul vor fi 0
            aux(0):=val4biti(3) xor val4biti(2); --xor intre bitul 3 si 2 pt a forma noul bit
            val4biti(3 downto 1):=val4biti(2 downto 0); --shift la dr
            val4biti(0):=aux(0); --se pune noul bit
          
          when "111"=>
            aux(0):=val8biti(7) xor val8biti(6); --noul bit
            val8biti(7 downto 1):=val8biti(6 downto 0); --shift la dr
            val8biti(0):=aux(0);
            nrr<=val8biti;
          
          when others=> nrr<=(others=>'0');
        end case;
      end if; 
     end if;
   end process;
end Behavioral;
