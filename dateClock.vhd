----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:09:05 03/25/2022 
-- Design Name: 
-- Module Name:    dateClock - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dateClock is
    Port ( clk : in  STD_LOGIC;
           seg : out  STD_LOGIC_VECTOR (6 downto 0);
           pos : out  STD_LOGIC_VECTOR (7 downto 0);
           dp : out  STD_LOGIC);
end dateClock;

architecture Behavioral of dateClock is

begin


end Behavioral;

