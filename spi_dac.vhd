----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:52:03 12/31/2017 
-- Design Name: 
-- Module Name:    spi_dac - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity spi_dac is
    Port ( clk : in  STD_LOGIC;
           SPI_MOSI : out  STD_LOGIC;
           SPI_SCK : out  STD_LOGIC;
           DAC_CS : out  STD_LOGIC;
           DAC_CLR : out  STD_LOGIC;
			  SPI_SS_B : out  STD_LOGIC;
			  AMP_CS : out  STD_LOGIC;
			  AD_CONV : out  STD_LOGIC;
			  SF_CE0 : out  STD_LOGIC;
			  FPGA_INIT_B : out  STD_LOGIC;
			  IO9 : out  STD_LOGIC;
			  IO10 : out  STD_LOGIC;
			  LED : out STD_LOGIC
			  --data_dds_dac: out STD_LOGIC_VECTOR(11 DOWNTO 0)
			  );
end spi_dac;

architecture Behavioral of spi_dac is
type state_type is (idle, write_DAC);
signal state : state_type := idle;
--signal data : std_logic_vector(31 downto 0):="11111111001111111111111111111111";
signal dataMSB : std_logic_vector(15 downto 0):="1111111100111111" ;
signal dataLSB : std_logic_vector(3 downto 0):="1111";
signal data_DDS : std_logic_vector(11 downto 0);
signal DDS_result : std_logic_vector(11 downto 0);
signal offset_DDS : std_logic_vector(11 downto 0):="100000000000";
signal data : std_logic_vector(31 downto 0);
signal cnt : integer range 0 to 32 := 0;
signal cnt2 : integer range 0 to 3 := 0;
--signal clkdiv : integer range 0 to 10;

--signal newclk : std_logic := '0';
signal dac_rdy : std_logic := '0';
--signal risingedge : std_logic := '1';
signal clock_en : std_logic := '0';
--signal reset : std_logic := '0';

COMPONENT dds8
  PORT (
    ce : IN STD_LOGIC;
	 clk : IN STD_LOGIC;
	 rdy : OUT STD_LOGIC;
    sine : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
  );
END COMPONENT;

begin
SPI_SS_B <='1';
AMP_CS <='1';
AD_CONV <='0';
SF_CE0 <='1';
FPGA_INIT_B <='0';
SPI_SCK <= clk;DAC_CLR<='1';
LED <= dac_rdy;
IO10<='1';
IO9<=clock_en;
--clock_en <='1';
dds_sine : dds8
  PORT MAP (
    ce => clock_en,
	 clk => clk,
	 rdy => dac_rdy,
    sine => data_DDS
  );

--DDS_result <= data_DDS + offset_DDS;
DDS_result <= std_logic_vector(unsigned(data_DDS) + unsigned(offset_DDS));
data <= dataMSB & DDS_result & dataLSB;
--data_dds_dac <=data_DDS;
--clock_divider: process(clk, reset)
--  begin
--		if(reset = '1') then
--		elsif(rising_edge(clk)) then
--			if(clkdiv = 2) then
--				risingedge <= risingedge xor '1';
--				newclk <= newclk xor '1';
--				clkdiv <= 0;
--			else
--				clkdiv <= clkdiv + 1;
--			end if;
--		end if;
--end process clock_divider;

main: process(clk)
	variable temp : integer;
 begin
   --if(reset = '1') then
   if(rising_edge(clk)) then
   --if(clkdiv = 2 and risingedge = '1') then
	  case state is
	    when idle =>
		    DAC_CS <= '1';
			 clock_en <='1';
			 if (cnt2 > 1) then
			    cnt2 <= 0;
				 state <= write_DAC;
			else
			    cnt2<=cnt2+ 1;
				 state<=idle;
			end if;
		 when write_DAC =>
		    DAC_CS <= '0';
			 clock_en <='0';
			 if(cnt < 32) then
			   cnt <= cnt + 1;
				--data <= dataMSB & data_DDS & dataLSB;
				SPI_MOSI <= data(31 - cnt);
				state <= write_DAC;
			else
				cnt <= 0;
				--DAC_CS <= '1';
				state <= idle;
			end if;
		end case;
	--end if;
  end if;
end process main;--with state select LED <= 
--'0' when idle,
--'1' when write_DAC,
--'0' when others;


end Behavioral;

