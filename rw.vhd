library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rw_16x8_Sync is
port (address: in std_logic_vector(3 downto 0);
data_in: in std_logic_vector(7 downto 0);
WE: in std_logic;
clock: in std_logic;
data_out: out std_logic_vector(7 downto 0));

end entity;

architecture rw_16x8_Sync_arch of rw_16x8_Sync is

type RW_type is array (0 to 15) of std_logic_vector (7 downto 0);

signal RW : RW_type;
begin

MEMORY : process (clock)
begin
if (clock'event and clock='1') then
if (WE = '1') then
RW(to_integer(unsigned(address))) <= data_in;

else data_out <= RW(to_integer(unsigned(address)));

end if;
end if;
end process;
end architecture;
