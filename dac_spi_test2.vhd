--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:33:58 01/05/2018
-- Design Name:   
-- Module Name:   C:/Users/Raman/Documents/Kickstarter_FPGA/spi_test/dac_spartan/dac_spi_test2.vhd
-- Project Name:  dac_spartan
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: spi_dac
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY dac_spi_test2 IS
END dac_spi_test2;
 
ARCHITECTURE behavior OF dac_spi_test2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT spi_dac
    PORT(
         clk : IN  std_logic;
         SPI_MOSI : OUT  std_logic;
         SPI_SCK : OUT  std_logic;
         DAC_CS : OUT  std_logic;
         DAC_CLR : OUT  std_logic;
         SPI_SS_B : OUT  std_logic;
         AMP_CS : OUT  std_logic;
         AD_CONV : OUT  std_logic;
         SF_CE0 : OUT  std_logic;
         FPGA_INIT_B : OUT  std_logic;
         IO9 : OUT  std_logic;
         IO10 : OUT  std_logic;
         LED : OUT  std_logic;
         data_dds_dac : OUT  std_logic_vector(11 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';

 	--Outputs
   signal SPI_MOSI : std_logic;
   signal SPI_SCK : std_logic;
   signal DAC_CS : std_logic;
   signal DAC_CLR : std_logic;
   signal SPI_SS_B : std_logic;
   signal AMP_CS : std_logic;
   signal AD_CONV : std_logic;
   signal SF_CE0 : std_logic;
   signal FPGA_INIT_B : std_logic;
   signal IO9 : std_logic;
   signal IO10 : std_logic;
   signal LED : std_logic;
   signal data_dds_dac : std_logic_vector(11 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: spi_dac PORT MAP (
          clk => clk,
          SPI_MOSI => SPI_MOSI,
          SPI_SCK => SPI_SCK,
          DAC_CS => DAC_CS,
          DAC_CLR => DAC_CLR,
          SPI_SS_B => SPI_SS_B,
          AMP_CS => AMP_CS,
          AD_CONV => AD_CONV,
          SF_CE0 => SF_CE0,
          FPGA_INIT_B => FPGA_INIT_B,
          IO9 => IO9,
          IO10 => IO10,
          LED => LED,
          data_dds_dac => data_dds_dac
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
