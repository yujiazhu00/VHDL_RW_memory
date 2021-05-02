LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
 
ENTITY rw_16x8_Sync_tb IS
END rw_16x8_Sync_tb;

architecture rw_16x8_Sync_tb_arch of rw_16x8_Sync_tb is

component rw_16x8_Sync

port (address: in std_logic_vector(3 downto 0);
data_in: in std_logic_vector(7 downto 0);
WE: in std_logic;
clock: in std_logic;
data_out: out std_logic_vector(7 downto 0));

end component;

signal clock_TB : std_logic := '0'; 
signal data_in_TB: std_logic_vector(7 downto 0);
signal WE_TB : std_logic;
signal address_TB : std_logic_vector(3 downto 0);
signal data_out_TB : std_logic_vector(7 downto 0);


constant clock_period : time := 20 ns;

begin

DUT1 : rw_16x8_Sync port map (clock => clock_TB,
			WE => WE_TB,
			address => address_TB,
			data_in => data_in_TB,
			data_out => data_out_TB);

-- Clock process definitions
Clock_process :process
begin
clock_TB <= '0';
wait for clock_period/2;
clock_TB <= '1';
wait for clock_period/2;
end process;

stim_proc: process
begin 

for I in 0 to 15 loop
WE_TB <= '1';
address_TB <= std_logic_vector(to_unsigned(I, 4));
data_in_TB <= std_logic_vector(to_unsigned(I, 8));
wait for 20 ns;
end loop;

for K in 0 to 15 loop
WE_TB <= '0';
address_TB <= std_logic_vector(to_unsigned(K, 4));
data_in_TB <= "00000000";
wait for 20 ns;
end loop;

end process;
end architecture;
