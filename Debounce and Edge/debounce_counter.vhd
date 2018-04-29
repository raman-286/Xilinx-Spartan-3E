
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity debounce_counter is
Port ( clk : in  STD_LOGIC;
           led : out  STD_LOGIC_VECTOR(7 DOWNTO 0);
			  IO : out  STD_LOGIC;
			  IO2 : out  STD_LOGIC;
           sw : in  STD_LOGIC
		);
end debounce_counter;

architecture Behavioral of debounce_counter is
  type state_type is (zero, one);
  signal state_reg, state_next: state_type;
  signal tick:std_logic;
  --signal tick2:std_logic;
  signal db_sw:std_logic;
  signal sw_inv:std_logic;
  signal counter:std_logic_vector(2 downto 0):= (others => '0');

begin
--IO <=sw;

sw_inv<=not sw;
--IO2<=clk;
IO <= tick;
IO2 <= db_sw;
--tick2 <= tick and clk;
--led(0)<=sw;
--led(7)<='1';
--led(6)<='1';
--led(5)<='1';
--led(4)<='1';
--led(3)<='1';
--led(2)<='1';
--led(1)<='1';

db_unit: entity work.debounce_ckt(Behavioral)
	 port map(
	          clk => clk,
				 sw => sw_inv,
				 db => db_sw
				 );

edge_det: process(clk)
     begin
	   if(clk'event and clk = '1') then
		  state_reg <= state_next;
		end if;
end process;


process(state_reg, db_sw)
	begin
	 state_next <= state_reg;
	 
	 tick <='0';
	 --led <='0';
	 case state_reg is
	   when zero =>
		  if db_sw = '1' then
		    state_next <= one;
			 
			 tick <='1';
			 --counter <= counter + 1;
		   end if;
		when one =>
		   if db_sw = '0' then
			  state_next <= zero;
			  end if;
	 end case;
	end process;

syn_process: process(clk, tick)
begin
if (clk'event and clk='1') then
 if (tick='1') then
   counter <= counter + 1;
 end if;
end if;
end process syn_process;


--comb_process: process(counter)
--begin
--case counter is
--   when 0 =>
--	   led<="10000000";
--	when 1 =>
--	   led<="01000000";
--	when 2 =>
--	   led<="00100000";
--	when 3 =>
--	   led<="00010000";
--	when 4 =>
--	   led<="00001000";
--   when 5 =>
--	   led<="00000100";
--   when 6 =>
--	   led<="00000010";
--   when 7 =>
--	   led<="00000001";
--   when others =>
--      led<="11111111";

comb_process: process(counter)
begin
case counter is
   when "000" =>
	   led<="10000000";
	when "001" =>
	   led<="01000000";
	when "010" =>
	   led<="00100000";
	when "011" =>
	   led<="00010000";
	when "100" =>
	   led<="00001000";
   when "101" =>
	   led<="00000100";
   when "110" =>
	   led<="00000010";
   when "111" =>
	   led<="00000001";
   when others =>
      led<="11111111";
end case;
end process;

end Behavioral;

