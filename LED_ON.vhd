library IEEE;
use ieee.std_logic_1164.all;
use work.all;

entity LED_ON is 
	port(
	clk : in std_logic; -- clock de 50Mhz
	segment, segment2, segment3, segment4, segment5, segment6 : buffer std_logic_vector(7 downto 0);
-- HEX 0     HEX 1      HEX 2      HEX 3    HEX 4      HEX 5
	SER1, SCLK1, SRCLK1, SER2, SCLK2, SRCLK2: out std_logic;
	boutton : in std_logic;
	VGA_HS : buffer std_logic;
   VGA_VS : buffer std_logic;
   VGA_R : buffer integer range 0 to 15;
   VGA_G : buffer integer range 0 to 15;
   VGA_B : buffer integer range 0 to 15);
end LED_ON;


architecture structural of LED_ON is
signal clockUsable, clockSec : std_logic; --differente clock du systeme
signal dizaine, unite : std_logic_vector(0 to 3) := "0000"; --dizaine contient le chiffre des dizaines en 4 bit et idem pour unite
signal temp : std_logic; --temp est la clock pour les differents état du systeme il ne contient rien
signal max : integer :=30; --valeur maximum du compteur pour le comptage et le decomptage peu utile
signal count : integer := 0; -- count permet de connaitre l'état actuel du systeme utile pour toi pour faire ton affichage visuel
signal enable1, enable2 : std_logic;

constant lPaletColor : integer := 16#222#; -- Couleur de la raquette gauche
constant backgroundColor : integer := 16#fff#; -- Couleur de fond
constant ballColor : integer := 16#888#; -- Couleur de la balle
constant vert : integer := 16#2f0#;
constant vertf : integer := 16#0f0#;
constant rouge : integer := 16#f20#;
constant orange : integer := 16#f80#;

TYPE image is ARRAY(0 to 3599) OF std_logic;



constant standing : image := ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','1','1','1','1','1','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','1','1','1','1','1','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','1','1','1','1','1','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','1','1','1','1','1','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','1','1','1','1','1','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','1','1','1','1','1','1','0','0','0','0','0','0',
'0','0','0','0','0','0','1','1','1','1','1','1','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','1','1','1','1','1','0','0','0','0','0','0',
'0','0','0','0','0','0','1','1','1','1','1','1','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','1','1','1','1','1','0','0','0','0','0','0',
'0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','1','1','1','1','1','1','0','0','0','0','0','0',
'0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','1','1','1','1','1','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','1','1','1','1','1','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','1','1','1','1','1','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','0','0','0','0','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0');

constant walking : image := ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','0','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','0','1','1','1','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','0','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','0','1','1','1','1','1','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','0','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','1','1','1','1','1','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','1','1','1','1','1','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','1','1','1','1','1','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0',
'0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0',
'0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0',
'0','0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0',
'0','0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0',
'0','0','0','0','0','0','0','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0');

alias Mclk is clk;

signal VGA_clk : std_logic; -- Horloge du fonctionnement VGA environ 25MHz
signal VGA_x : integer range 0 to 639; -- Axe x (colonnes)
signal VGA_y : integer range 0 to 479; -- Axe y (lignes)
signal pixel : std_logic; -- Si '1', affichera un pixel blanc à l'emplacement du curseur
signal color : integer range 0 to 4096; -- Couleur en héxadécimal


begin


	VGA_Divider : process( Mclk ) -- 25MHz pour le VGA
    begin
        if rising_edge(Mclk) then
            VGA_clk <= not VGA_clk;
        end if ;
    end process ; -- VGA_Divider
    
    VGA_Sub : entity work.VGA port map( -- Entitée contrôle écran VGA
            clk => VGA_clk, -- Horloge VGA
            HS => VGA_HS, -- Signal synchro horizontal
            VS => VGA_VS, -- Signal synchro verticale
            R_out => VGA_R, -- Signal rouge sortie
            G_out => VGA_G, -- Signal vert sortie
            B_out => VGA_B, -- Signal bleu sortie
            x => VGA_x, -- Coordonnées X actuelles
            y => VGA_y, -- Coordonnées Y actuelles
            RGB_in => color,
            pixel => pixel -- Signal forcé couleur blanche
    );
	

	fS1 :entity clockM(structural) --Clock Principale du circuit permet de réduire la clock de 50Mhz a une clock de 1hz
	generic map(max => 50000000) --definition de la valeur maximum pour modification facile dans le cas ou l'on passe a la clock de 10Mhz
	port map(clkS => clk,clockout => clockUsable); --mappage des ports pour la suite du programme
	
	
	--FS2 et FS2 value font le comptage et le decomptage pour le programme globale pour simplifier le systeme
	
	fs2 : entity EtatFeu(structural) -- gestion des clocks pour les feux elle renvoie dizaine et unite pour affichage
	port map(clkS => clockUsable, clkOut => temp, maxV => max, dizaine => dizaine, unite => unite);
	
	fs2_value : entity max_value(structural) --gere le passage dans les differents mode du feux
	port map(clock => temp, maxV => max, result => segment5, result2 => segment6, counter => count);
	--LEDR1 => ledR, LEDO1=> ledO, LEDV1 => ledv, LEDR2 => ledR2, LEDO2 => ledo2, LEDV2 => ledv2);
	
	
	fs3_Temps : entity AffichageTemps(structural)
	port map(enable1 => enable1, enable2 => enable2, compteur => count);
	
	--Affichage Compteur feu 1
	
	fs3_affichage_dizaine_feu1 : entity afficheur(structural)
	port map(valeur => dizaine, resultS => segment2, enable => enable1);
	
	fs3_affichage_unite_feu1 : entity afficheur(structural)
	port map(valeur => unite, resultS => segment, enable => enable1);
	
	--Affichage compteur feu 2
	
	fs3_affichage_dizaine_feu2 : entity afficheur(structural)
	port map(valeur => dizaine, resultS => segment4, enable => enable2);
	
	fs3_affichage_unite_feu2 : entity afficheur(structural)
	port map(valeur => unite, resultS => segment3, enable => enable2);
	
	pixel_print : process( VGA_x, VGA_y ) -- Choisis d'afficher un pixel ou non
    begin
		
        color <= backgroundColor;
        pixel <= '0';
		
		
		
		
		
		
		if (VGA_x <= 85) and (VGA_x >= 75) and (VGA_y >= 150) and (VGA_y <= 200) then -- Structure feu1
            color <= lPaletColor;
		end if ;
		if (VGA_x <= 230) and (VGA_x >= 85) and (VGA_y >= 150) and (VGA_y <= 160) then 
            color <= lPaletColor;
		end if ;
		if (VGA_x <= 230) and (VGA_x >= 220) and (VGA_y >= 160) and (VGA_y <= 250) then 
            color <= lPaletColor;
		end if ;
		if (VGA_x <= 280) and (VGA_x >= 170) and (VGA_y >= 250) and (VGA_y <= 350) then 
            color <= lPaletColor;
		end if ;
		
		if (VGA_x <= 375) and (VGA_x >= 365) and (VGA_y >= 150) and (VGA_y <= 200) then -- Structure FEU2
            color <= lPaletColor;
		end if ;
		if (VGA_x <= 520) and (VGA_x >= 375) and (VGA_y >= 150) and (VGA_y <= 160) then 
            color <= lPaletColor;
		end if ;
		if (VGA_x <= 520) and (VGA_x >= 510) and (VGA_y >= 160) and (VGA_y <= 250) then 
            color <= lPaletColor;
		end if ;
		if (VGA_x <= 570) and (VGA_x >= 460) and (VGA_y >= 250) and (VGA_y <= 350) then 
            color <= lPaletColor;
		end if ;
		
		
		if (VGA_x <= 130) and (VGA_x >= 30) and (VGA_y >= 200) and (VGA_y <= 500) then -- FEU1
            color <= lPaletColor;
		end if ;
		
		if (((VGA_x -80)*(VGA_x -80) + (VGA_y -250)*(VGA_y -250) )<= 900)-- ROND1
        then
				if (segment5 = "11111001" )
					then
					color <= rouge;
				elsif (segment5 = "10100100" )
					then
					color <= rouge;
				elsif (segment5 = "10110000" )
					then
					color <= ballColor;
				elsif (segment5 = "10011001" )
					then
					color <= ballColor;
				end if;
		elsif (((VGA_x -80)*(VGA_x -80) + (VGA_y -330)*(VGA_y -330) )<= 900)-- ROND2
        then
            if (segment5 = "11111001" )
					then
					color <= ballColor;
				elsif (segment5 = "10100100" )
					then
					color <= ballColor;
				elsif (segment5 = "10110000" )
					then
					color <= ballColor;
				elsif (segment5 = "10011001" )
					then
					color <= orange;
				end if;
		elsif (((VGA_x -80)*(VGA_x -80) + (VGA_y -410)*(VGA_y -410) )<= 900)-- ROND3
        then
            if (segment5 = "11111001" )
					then
					color <= ballColor;
				elsif (segment5 = "10100100" )
					then
					color <= ballColor;
				elsif (segment5 = "10110000" )
					then
					color <= vert;
				elsif (segment5 = "10011001" )
					then
					color <= ballColor;
				end if;
        
		end if ;
		
		if (VGA_x <= 220) and (VGA_x >= 175) and (VGA_y >= 260) and (VGA_y <= 340) then --piéton vert 
				
				
            if ((segment5 = "11111001" ) or (segment5 = "10100100" ))
					then
					if (walking((VGA_x - 220) + ((VGA_y-260)*45)) = '1') then
						color <= vert;
					elsif (walking((VGA_x - 220) + ((VGA_y-260)*45)) = '0') then
						color <= ballColor;
					end if;
				elsif ((segment5 = "10110000" ) or (segment5 = "10011001" ))
					then
					color <= ballColor;
				end if;
				
				
				
		end if ;
		if (VGA_x <= 275) and (VGA_x >= 230) and (VGA_y >= 260) and (VGA_y <= 340) then--piéton rouge 
            if ((segment5 = "11111001" ) or (segment5 = "10100100" ))
					then
					color <= ballColor;
				elsif ((segment5 = "10110000" ) or (segment5 = "10011001" ))
					then
					if (standing((VGA_x - 275) + ((VGA_y-260)*45)) = '1') then
						color <= rouge;
					elsif (standing((VGA_x - 275) + ((VGA_y-260)*45)) = '0') then
						color <= ballColor;
					end if;
				end if;
		end if ;
		
		
		
		
		
		if (VGA_x <= 420) and (VGA_x >= 320) and (VGA_y >= 200) and (VGA_y <= 500) then -- FEU2
            color <= lPaletColor;
		end if ;
		if (((VGA_x -370)*(VGA_x -370) + (VGA_y -250)*(VGA_y -250) )<= 900)-- ROND1
        then
            if (segment5 = "11111001" )
					then
					color <= ballColor;
				elsif (segment5 = "10100100" )
					then
					color <= ballColor;
				elsif (segment5 = "10110000" )
					then
					color <= rouge;
				elsif (segment5 = "10011001" )
					then
					color <= rouge;
				end if;
		elsif (((VGA_x -370)*(VGA_x -370) + (VGA_y -330)*(VGA_y -330) )<= 900)-- ROND2
        then
            if (segment5 = "11111001" )
					then
					color <= ballColor;
				elsif (segment5 = "10100100" )
					then
					color <= orange;
				elsif (segment5 = "10110000" )
					then
					color <= ballColor;
				elsif (segment5 = "10011001" )
					then
					color <= ballColor;
				end if;
		elsif (((VGA_x -370)*(VGA_x -370) + (VGA_y -410)*(VGA_y -410) )<= 900)-- ROND3
        then
            if (segment5 = "11111001" )
					then
					color <= vert;
				elsif (segment5 = "10100100" )
					then
					color <= ballColor;
				elsif (segment5 = "10110000" )
					then
					color <= ballColor;
				elsif (segment5 = "10011001" )
					then
					color <= ballColor;
				end if;
        
		end if ;
		if (VGA_x <= 510) and (VGA_x >= 465) and (VGA_y >= 260) and (VGA_y <= 340) then--piéton vert 
            if ((segment5 = "11111001" ) or (segment5 = "10100100" ))
					then
					color <= ballColor;
				elsif ((segment5 = "10110000" ) or (segment5 = "10011001" ))
					then
					if (walking((VGA_x - 510) + ((VGA_y-260)*45)) = '1') then
						color <= vert;
					elsif (walking((VGA_x - 510) + ((VGA_y-260)*45)) = '0') then
						color <= ballColor;
					end if;
				end if;
		end if ;
		if (VGA_x <= 565) and (VGA_x >= 520) and (VGA_y >= 260) and (VGA_y <= 340) then--piéton rouge 
            if ((segment5 = "11111001" ) or (segment5 = "10100100" ))
					then
					if (standing((VGA_x - 565) + ((VGA_y-260)*45)) = '1') then
						color <= rouge;
					elsif (standing((VGA_x - 565) + ((VGA_y-260)*45)) = '0') then
						color <= ballColor;
					end if;
				elsif ((segment5 = "10110000" ) or (segment5 = "10011001" ))
					then
					color <= ballColor;
				end if;
		end if ;
		
		
		
		
		
		
    end process ; -- pixel_print
	
end structural;