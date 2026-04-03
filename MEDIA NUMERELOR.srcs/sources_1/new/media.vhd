library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity media is 
   Port(nrr: in std_logic_vector(7 downto 0);
	    clk_datee: in std_logic;  
	    rst_mediee: in std_logic;                    
	    lungimee: in std_logic_vector(2 downto 0);                          
	    ultimm: out std_logic_vector(7 downto 0);--iesire care tine ultimul nr generat
	    mediee: out std_logic_vector(7 downto 0));--media nr
end media;

architecture Behavioral of media is	
--vector pt a stoca ultimele n val
type memorie is array (15 downto 0) of unsigned(11 downto 0);
--bufferul circular ce reține ultimele 16 numere
signal numere: memorie:=(others=>(others=>'0'));
begin 
  process(clk_datee)
  --variabile pt stocarea sumelor intermediare
  type s is array (3 downto 0) of std_logic_vector(7 downto 0);
  type s2 is array(7 downto 0) of unsigned(11 downto 0);
  type s4 is array(7 downto 0) of unsigned(11 downto 0);
  type s8 is array(7 downto 0) of unsigned(11 downto 0);
  variable suma: s;	--vector cu medii finale(pt 4, 8, 12, 16)
  variable suma2: s2;
  variable suma4: s4;
  variable suma8: s8;
  variable suma16: unsigned(11 downto 0); --suma totala a 16 valori
  variable aux: unsigned(11 downto 0):=(others=>'0');
  --aux retine valoarea de intr pe 12 biti 
  --pt calcule de medie fara overflow
  begin
    if(rising_edge(clk_datee) and lungimee/="000") then
	  if(rst_mediee='1') then --goleste memoria
	    numere<=(others=>(others=>'0'));
		mediee<=(others=>'0'); 
	  else
	  --copiaza val nr in partea de jos a lui aux
	  --pt a putea face operatiile aritmetice
	    aux(7 downto 0):=unsigned(nrr);
		--setam bitii superiori ai lui aux(8-11) la 0
		--extindere pe 12 biti pt a evita overlow ul
		aux(11 downto 8):=(others => '0');
		--shift la dreapta in vectorul de memorie
		--numbers(14) devine numbers(15), numbers(13) devine numbers(14), etc
		for i in 15 downto 1 loop
          numere(i)<=numere(i-1);
        end loop;
		--adaugam noua val aux pe prima poz a bufferului
		--reprez cel mai recent nr primit
		numere(0)<=aux;
		
		adunare2: for i in 7 downto 0 loop
		  suma2(i):=numere(i*2)+numere(i*2+1);
	    end loop;
	    aux:=suma2(0)srl 1;
	    suma(0):=std_logic_vector(aux(7 downto 0));
	      
	    adunare4: for i in 3 downto 0 loop
		  suma4(i):=suma2(i*2)+suma2(i*2+1);
	    end loop;
	    aux:=suma4(0)srl 2;
	    suma(1):=std_logic_vector(aux(7 downto 0));
	      
	    adunare8: for i in 1 downto 0 loop
		  suma8(i):=suma4(i*2)+suma4(i*2+1);
	    end loop;
	    aux:=suma8(0)srl 3;
	    suma(2):=std_logic_vector(aux(7 downto 0));
	      
	    suma16:=suma8(0)+suma8(1);
	    aux:=suma16 srl 4;
	    suma(3):=std_logic_vector(aux(7 downto 0));
	      
	    case lungimee is
		  when "100"=> mediee<=suma(0);--se calc suma tot a cate 4 nr fol 
		  --sumele precedente si la fiecare 4 nr deplasam suma lor cu 
		  --2 pozitii spre dreapta
		  when "101"=> mediee<=suma(1);
		  when "110"=> mediee<=suma(2);
		  when "111"=> mediee<=suma(3);
		  when others=> 
		    ultimm<=(others=>'0');
			mediee<=(others=>'0');
		end case;
		ultimm<=nrr; 
	  end if;
	end if;
end process;

end Behavioral;
