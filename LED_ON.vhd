library IEEE;
use ieee.std_logic_1164.all;
use work.all;

entity LED_ON is 
	port(
	clk : in std_logic; -- clock de 50Mhz
	segment, segment2, segment3, segment4, segment5, segment6 : inout std_logic_vector(7 downto 0);
-- HEX 0     HEX 1      HEX 2      HEX 3    HEX 4      HEX 5
	SER1, SCLK1, SER2, SCLK2: out std_logic;
	SRCLK1, SRCLK2 : inout std_logic := '0';
	buzzer : out std_logic;
	boutton : in std_logic;
	VGA_HS : out std_logic;
   VGA_VS : out std_logic;
   VGA_R : out integer range 0 to 15;
   VGA_G : out integer range 0 to 15;
   VGA_B : out integer range 0 to 15);
end LED_ON;


architecture structural of LED_ON is
signal clockUsable,clockUsable2, clockSec, clockBuzzerFeu1, clockBuzzerFeu2 : std_logic; --differente clock du systeme
signal dizaine, unite : std_logic_vector(0 to 3) := "0000"; --dizaine contient le chiffre des dizaines en 4 bit et idem pour unite
signal temp : std_logic; --temp est la clock pour les differents état du systeme il ne contient rien
signal max : integer :=30; --valeur maximum du compteur pour le comptage et le decomptage peu utile
signal count : integer := 0; -- count permet de connaitre l'état actuel du systeme utile pour toi pour faire ton affichage visuel
signal enable1, enable2 : std_logic;
signal stdby : std_logic := '0';
signal TAB_LED1, TAB_LED2 : std_logic_vector(0 to 7) := "00000000";
signal selecBuzzer : std_logic_vector(0 to 1);

begin

	-- FS1
	fS1 :entity clockM(structural) --Clock Principale du circuit permet de réduire la clock de 50Mhz a une clock de 1hz
	generic map(max => 50000000) --definition de la valeur maximum pour modification facile dans le cas ou l'on passe a la clock de 10Mhz
	port map(clkS => clk,clockout => clockUsable); --mappage des ports pour la suite du programme
	
	fS1_25MHZ :entity clockM(structural) --Clock Principale du circuit permet de réduire la clock de 50Mhz a une clock de 1hz
	generic map(max => 2) --definition de la valeur maximum pour modification facile dans le cas ou l'on passe a la clock de 10Mhz
	port map(clkS => clk,clockout => clockUsable2); --mappage des ports pour la suite du programme
	
	fs1_buzzer : entity Sirene(structural)
	generic map(max => 113636, max2 => 83333)
	port map(clk => clk, selec => selecBuzzer, buzzer => buzzer);
	
	
	--FS2 et FS2 value font le comptage et le decomptage pour le programme globale pour simplifier le systeme
	
	fs2 : entity EtatFeu(structural) -- gestion des clocks pour les feux elle renvoie dizaine et unite pour affichage
	port map(clkS => clockUsable, clkOut => temp, maxV => max, dizaine => dizaine, unite => unite, stdby => stdby);
	
	fs2_value : entity max_value(structural) --gere le passage dans les differents mode du feux
	port map(clock => temp, maxV => max, result => segment5, result2 => segment6, counter => count, stdby => stdby, TAB_LED1 => TAB_LED1, TAB_LED2 => TAB_LED2, selecBuzzer => selecBuzzer);
	--LEDR1 => ledR, LEDO1=> ledO, LEDV1 => ledv, LEDR2 => ledR2, LEDO2 => ledo2, LEDV2 => ledv2);
	
	
	--FS3
	
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
	
	
	fs3_debounce : entity debounce(structural)
	port map(cclk => clk, inp => boutton, outp => stdby);
	
	FSLED1 : entity registerLED(structural)
	port map(clk => clockUsable2,valeur => TAB_LED1, SER => SER1, SCLK => SCLK1, SRCLK => SRCLK1);
	
	FSLED2 : entity registerLED(structural)
	port map(clk => clockUsable2, valeur => TAB_LED2, SER => SER2, SCLK => SCLK2, SRCLK => SRCLK2);	
	--FS4
	
	FS4 : entity VGA_display(structural)
	port map(clk => clk, segment => segment, segment2 => segment2, segment3 => segment3,segment4 => segment4, segment5 => segment5, segment6 => segment6,
	VGA_HS => VGA_HS, VGA_VS => VGA_VS, VGA_R => VGA_R, VGA_B => VGA_B, VGA_G => VGA_G);
	
end structural;