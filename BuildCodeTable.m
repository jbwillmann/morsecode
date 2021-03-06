function codeTable = BuildCodeTable()
% Function to build initial codeTable cell array
    %   The columns in the codeTable are
    %   1   Code Character
    %   2   Dot's and dashes
    %   3   dit's and daw's
    %   4   code word
    %   5   code display
    %   6   Wave file of character - to be added outside this function

    codeTable = cell(60,6);

    %   Letters
        codeTable{1,1} = 'A';
            codeTable{1,2} = '.-';
            codeTable{1,3} = 'dit daw';
            codeTable{1,4} = 'Alpha';
            codeTable{1,5} = '� �';
        codeTable{2,1} = 'B';
            codeTable{2,2} = '-...';
            codeTable{2,3} = 'daw dit dit dit';
            codeTable{2,4} = 'Bravo';
            codeTable{2,5} = '� � � �';
        codeTable{3,1} = 'C';
            codeTable{3,2} = '-.-.';
            codeTable{3,3} = 'daw dit daw dit';
            codeTable{3,4} = 'Charlie';
            codeTable{3,5} = '� � � �';
        codeTable{4,1} = 'D';
            codeTable{4,2} = '-..';
            codeTable{4,3} = 'daw dit dit';
            codeTable{4,4} = 'Delta';
            codeTable{4,5} = '� � �';
        codeTable{5,1} = 'E';
            codeTable{5,2} = '.';
            codeTable{5,3} = 'dit';
            codeTable{5,4} = 'Echo';
            codeTable{5,5} = '�';
        codeTable{6,1} = 'F';
            codeTable{6,2} = '..-.';
            codeTable{6,3} = 'dit dit daw dit';
            codeTable{6,4} = 'Foxtrot';
            codeTable{6,5} = '� � � �';
        codeTable{7,1} = 'G';
            codeTable{7,2} = '--.';
            codeTable{7,3} = 'daw daw dit';
            codeTable{7,4} = 'Golf';
            codeTable{7,5} = '� � �';
        codeTable{8,1} = 'H';
            codeTable{8,2} = '....';
            codeTable{8,3} = 'dit dit dit dit';
            codeTable{8,4} = 'Hotel';
            codeTable{8,5} = '� � � �';
        codeTable{9,1} = 'I';
            codeTable{9,2} = '..';
            codeTable{9,3} = 'dit dit';
            codeTable{9,4} = 'India';
            codeTable{9,5} = '� �';
        codeTable{10,1} = 'J';
            codeTable{10,2} = '.---';
            codeTable{10,3} = 'dit daw daw daw';
            codeTable{10,4} = 'Juliet';
            codeTable{10,5} = '� � � �';
        codeTable{11,1} = 'K';
            codeTable{11,2} = '-.-';
            codeTable{11,3} = 'daw dit daw';
            codeTable{11,4} = 'Kilo';
            codeTable{11,5} = '� � �';
        codeTable{12,1} = 'L';
            codeTable{12,2} = '.-..';
            codeTable{12,3} = 'dit daw dit dit';
            codeTable{12,4} = 'Lima';
            codeTable{12,5} = '� � �';
        codeTable{13,1} = 'M';
            codeTable{13,2} = '--';
            codeTable{13,3} = 'daw daw';
            codeTable{13,4} = 'Mike';
            codeTable{13,5} = '� �';
        codeTable{14,1} = 'N';
            codeTable{14,2} = '-.';
            codeTable{14,3} = 'daw dit';
            codeTable{14,4} = 'November';
            codeTable{14,5} = '� �';
        codeTable{15,1} = 'O';
            codeTable{15,2} = '---';
            codeTable{15,3} = 'daw daw daw';
            codeTable{15,4} = 'Oscar';
            codeTable{15,5} = '� � �';
        codeTable{16,1} = 'P';
            codeTable{16,2} = '.--.';
            codeTable{16,3} = 'dit daw daw dit';
            codeTable{16,4} = 'Papa';
            codeTable{16,5} = '� � � �';
        codeTable{17,1} = 'Q';
            codeTable{17,2} = '--.-';
            codeTable{17,3} = 'daw daw dit daw';
            codeTable{17,4} = 'Quebec';
            codeTable{17,5} = '� � � �';
        codeTable{18,1} = 'R';
            codeTable{18,2} = '.-.';
            codeTable{18,3} = 'dit daw dit';
            codeTable{18,4} = 'Romeo';
            codeTable{18,5} = '� � �';
        codeTable{19,1} = 'S';
            codeTable{19,2} = '...';
            codeTable{19,3} = 'dit dit dit';
            codeTable{19,4} = 'Sierra';
            codeTable{19,5} = '� � �';
        codeTable{20,1} = 'T';
            codeTable{20,2} = '-';
            codeTable{20,3} = 'daw';
            codeTable{20,4} = 'Tango';
            codeTable{20,5} = '�';
        codeTable{21,1} = 'U';
            codeTable{21,2} = '..-';
            codeTable{21,3} = 'dit dit daw';
            codeTable{21,4} = 'Uniform';
            codeTable{21,5} = '� � �';
        codeTable{22,1} = 'V';
            codeTable{22,2} = '...-';
            codeTable{22,3} = 'dit dit dit daw';
            codeTable{22,4} = 'Victor';
            codeTable{22,5} = '� � � �';
        codeTable{23,1} = 'W';
            codeTable{23,2} = '.--';
            codeTable{23,3} = 'dit daw daw';
            codeTable{23,4} = 'Whiskey';
            codeTable{23,5} = '� � �';
        codeTable{24,1} = 'X';
            codeTable{24,2} = '-..-';
            codeTable{24,3} = 'daw dit dit daw';
            codeTable{24,4} = 'X-ray';
            codeTable{24,5} = '� � � �';
        codeTable{25,1} = 'Y';
            codeTable{25,2} = '-.--';
            codeTable{25,3} = 'daw dit daw daw';
            codeTable{25,4} = 'Yankee';
            codeTable{25,5} = '� � � �';
        codeTable{26,1} = 'Z';
            codeTable{26,2} = '--..';
            codeTable{26,3} = 'daw daw dit dit';
            codeTable{26,4} = 'Zulu';
            codeTable{26,5} = '� � � �';

    %   Numbers
        codeTable{27,1} = '1';
            codeTable{27,2} = '.----';
            codeTable{27,3} = 'dit daw daw daw daw';
            codeTable{27,4} = 'One';
            codeTable{27,5} = '� � � � �';
        codeTable{28,1} = '2';
            codeTable{28,2} = '..---';
            codeTable{28,3} = 'dit dit daw daw daw';
            codeTable{28,4} = 'Two';
            codeTable{28,5} = '� � � � �';
        codeTable{29,1} = '3';
            codeTable{29,2} = '...--';
            codeTable{29,3} = 'dit dit dit daw daw';
            codeTable{29,4} = 'Three';
            codeTable{29,5} = '� � � � �';
        codeTable{30,1} = '4';
            codeTable{30,2} = '....-';
            codeTable{30,3} = 'dit dit dit dit daw';
            codeTable{30,4} = 'Four';
            codeTable{30,5} = '� � � � �';
        codeTable{31,1} = '5';
            codeTable{31,2} = '.....';
            codeTable{31,3} = 'dit dit dit dit dit';
            codeTable{31,4} = 'Five';
            codeTable{31,5} = '� � � � �';
        codeTable{32,1} = '6';
            codeTable{32,2} = '-....';
            codeTable{32,3} = 'daw dit dit dit dit';
            codeTable{32,4} = 'Six';
            codeTable{32,5} = '� � � � �';
        codeTable{33,1} = '7';
            codeTable{33,2} = '--...';
            codeTable{33,3} = 'daw daw dit dit dit';
            codeTable{33,4} = 'Seven';
            codeTable{33,5} = '� � � � �';
        codeTable{34,1} = '8';
            codeTable{34,2} = '---..';
            codeTable{34,3} = 'daw daw daw dit dit';
            codeTable{34,4} = 'Eight';
            codeTable{34,5} = '� � � � �';
        codeTable{35,1} = '9';
            codeTable{35,2} = '----.';
            codeTable{35,3} = 'daw daw daw daw dit';
            codeTable{35,4} = 'Nine';
            codeTable{35,5} = '� � � � �';
        codeTable{36,1} = '0';
            codeTable{36,2} = '-----';
            codeTable{36,3} = 'daw daw daw daw daw';
            codeTable{36,4} = 'Zero';
            codeTable{36,5} = '� � � � �';

    %   Punctuation
        codeTable{37,1} = ',';
            codeTable{37,2} = '--..--';
            codeTable{37,3} = 'daw daw dit dit daw daw';
            codeTable{37,4} = 'Comma';
            codeTable{37,5} = '� � � � � �';
        codeTable{38,1} = '.';
            codeTable{38,2} = '.-.-.-';
            codeTable{38,3} = 'dit daw dit daw dit daw';
            codeTable{38,4} = 'Period';
            codeTable{38,5} = '� � � � � �';
        codeTable{39,1} = '?';
            codeTable{39,2} = '..--..';
            codeTable{39,3} = 'dit dit daw daw dit dit';
            codeTable{39,4} = 'Question Mark';
            codeTable{39,5} = '� � � � � �';
        codeTable{40,1} = ';';
            codeTable{40,2} = '-.-.-.';
            codeTable{40,3} = 'daw dit daw dit daw dit';
            codeTable{40,4} = 'Semicolon';
            codeTable{40,5} = '� � � � � �';
        codeTable{41,1} = ':';
            codeTable{41,2} = '---...';
            codeTable{41,3} = 'daw daw daw dit dit dit';
            codeTable{41,4} = 'Colon';
            codeTable{41,5} = '� � � � � �';
        codeTable{42,1} = '/';
            codeTable{42,2} = '-..-.';
            codeTable{42,3} = 'daw dit dit daw dit';
            codeTable{42,4} = 'Forward Slash';
            codeTable{42,5} = '� � � � �';
        codeTable{43,1} = '=';
            codeTable{43,2} = '-...-';
            codeTable{43,3} = 'daw dit dit dit daw';
            codeTable{43,4} = 'Equal';
            codeTable{43,5} = '� � � � �';
        codeTable{44,1} = '''';
            codeTable{44,2} = '.----.';
            codeTable{44,3} = 'dit daw daw daw daw dit';
            codeTable{44,4} = 'Apostrophe';
            codeTable{44,5} = '';
        codeTable{45,1} = '(';
            codeTable{45,2} = '-.--.';
            codeTable{45,3} = 'daw dit daw daw dit';
            codeTable{45,4} = 'Open Parenthesis';
            codeTable{45,5} = '� � � � �';
        codeTable{46,1} = ')';
            codeTable{46,2} = '-.--.-';
            codeTable{46,3} = 'daw dit daw daw dit daw';
            codeTable{46,4} = 'Close Parenthesis';
            codeTable{46,5} = '� � � � � �';
        codeTable{47,1} = '-';
            codeTable{47,2} = '-....-';
            codeTable{47,3} = 'daw dit dit dit dit daw';
            codeTable{47,4} = 'Hypen';
            codeTable{47,5} = '� � � � � �';
        codeTable{48,1} = '+';
            codeTable{48,2} = '.-.-.';
            codeTable{48,3} = 'dit daw dit daw dit';
            codeTable{48,4} = 'Plus';
            codeTable{48,5} = '� � � � �';
        codeTable{49,1} = '@';
            codeTable{49,2} = '.--.-.';
            codeTable{49,3} = 'dit daw daw dit daw dit';
            codeTable{49,4} = 'Ampersat';
            codeTable{49,5} = '� � � � � �';
        codeTable{50,1} = '"';
            codeTable{50,2} = '.-..-.';
            codeTable{50,3} = 'dit daw dit dit daw dit';
            codeTable{50,4} = 'Quote';
            codeTable{50,5} = '� � � � � �';
        codeTable{51,1} = '!';
            codeTable{51,2} = '-.-.--';
            codeTable{51,3} = 'daw dit daw dit daw daw';
            codeTable{51,4} = 'Exclamation Mark';
            codeTable{51,5} = '� � � � � �';
        codeTable{52,1} = '$';
            codeTable{52,2} = '...-..-';
            codeTable{52,3} = 'dit dit dit daw dit dit daw';
            codeTable{52,4} = 'Dollar Sign';
            codeTable{52,5} = '� � � � � � �';
        codeTable{53,1} = '&';
            codeTable{53,2} = '.-...';
            codeTable{53,3} = 'dit daw dit dit dit';
            codeTable{53,4} = 'Ampersand';
            codeTable{53,5} = '� � � � �';

    %   Special Alphabet Characters
        codeTable{54,1} = '�';
            codeTable{54,2} = '.--.-';
            codeTable{54,3} = 'dit daw daw dit daw';
            codeTable{54,4} = '';
            codeTable{54,5} = '';
        codeTable{55,1} = '�';
            codeTable{55,2} = '.-.-';
            codeTable{55,3} = 'dit daw dit daw';
            codeTable{55,4} = '';
            codeTable{55,5} = '';
        codeTable{56,1} = '�';
            codeTable{56,2} = '..-..';
            codeTable{56,3} = 'dit dit daw dit dit';
            codeTable{56,4} = '';
            codeTable{56,5} = '';
        codeTable{57,1} = '�';
            codeTable{57,2} = '--.--';
            codeTable{57,3} = 'daw daw dit daw daw';
            codeTable{57,4} = '';
            codeTable{57,5} = '';
        codeTable{58,1} = '�';
            codeTable{58,2} = '---.';
            codeTable{58,3} = 'daw daw daw dit';
            codeTable{58,4} = '';
            codeTable{58,5} = '';
        codeTable{59,1} = '�';
            codeTable{59,2} = '..--';
            codeTable{59,3} = 'dit dit daw daw';
            codeTable{59,4} = '';
            codeTable{59,5} = '';

        %   Word space
        codeTable{60,1} = ' ';
            codeTable{60,2} = '   ';
            codeTable{60,3} = '   ';
            codeTable{60,4} = 'Space';
            codeTable{60,5} = '';
end % end BuildCodeTable
