###################################################################################################
#
#  Name:        Timbre Freeman
#  Assignment:  Rock Paper Scissors
#  Date:        10/09/2019
#  Class:       CIS 282
#  Description: Rock-Scissors-Paper game - each player pick one of the options then check who wins
#
###################################################################################################

$debug = false

# Game logic
# Game weapons
$game_weapon = ["Rock", "Paper", "Scissors"]
# Who wins - 1 for player 1, 2 for player 2, 0 for nether
def who_win(player_1_weapon,player_2_weapon)
  if ((player_1_weapon == 1 && (player_2_weapon == 3 || player_2_weapon == 4)) ||
      (player_1_weapon == 2 && (player_2_weapon == 1 || player_2_weapon == 5)) ||
      (player_1_weapon == 3 && (player_2_weapon == 2 || player_2_weapon == 4)) ||
      (player_1_weapon == 4 && (player_2_weapon == 5 || player_2_weapon == 2)) ||
      (player_1_weapon == 5 && (player_2_weapon == 3 || player_2_weapon == 1)))
    return 1
  elsif((player_2_weapon == 1 && (player_1_weapon == 3 || player_1_weapon == 4)) ||
        (player_2_weapon == 2 && (player_1_weapon == 1 || player_1_weapon == 5)) ||
        (player_2_weapon == 3 && (player_1_weapon == 2 || player_1_weapon == 4)) ||
        (player_2_weapon == 4 && (player_1_weapon == 5 || player_1_weapon == 2)) ||
        (player_2_weapon == 5 && (player_1_weapon == 3 || player_1_weapon == 1)))
    return 2
  else
    return 0
  end
end

# Prints and ask the user to pick a option from the menu
def menu(options,with_exit)
  # Ask again
  input_work = false
  while !input_work
    # to prevent a loop
    input_work = true
    # Print the menu
    for i in 1..options.length
      puts "(#{i}) #{options[i-1]}"
    end
    # check if there is a exit
    if (with_exit)
      # Print the exit
      puts "(#{options.length+1}) to exit"
    end
    # ask user for there opinion
    print "Enter a opinion: "
    input = gets.chomp.to_i
    # check if input is valid
    if (!((input <= options.length) && (input > 0)))
      if (with_exit && input <= options.length+2)
        input_work = true
      else
        puts "Your input is not a opinion available"
        input_work = false
      end
    else
      input_work = true
    end
    # check if user it trying to turn on debug
    if (with_exit && input == options.length+2)
      $debug = !$debug
      puts "Debug is On" if ($debug)
      puts "Debug is Off" if (!$debug)
      input_work = false
    elsif (input == options.length+2)
      input_work = false
      puts "Debug can not be accessed from this menu"
    end
  end
  puts ""
  return input
end

# repeat the program in tell told other wise
run_program = true
while run_program
  # Welcome screen
  puts "################################"
  puts "#Welcome to Rock Paper Scissors#"
  puts "################################"
  # Start Menu
  start_menu = [
      "Start the game",
      "Toggle \"Sheldon Rock Paper Scissors\" game",
      "Explain how the game works"
      ]
  # Launch menu
  user_start_menu_input = menu(start_menu,true)
  # Option 1
  if (user_start_menu_input == 1)
    # Check who playing who
    start_game_menu = [
        "Player 1 vs Computer",
        "Player 1 vs Player 2",
        "Computer 1 vs Computer 2"
    ]
    # Launch the question
    user_start_game_menu_input = menu(start_game_menu,false)
    # Setting Variables
    players_weapon = Array.new(2)
    players_win = Array.new(3, 0)
    who_is_playing = 1
    while (!(who_is_playing == 0))
      # Say who is going
      if (who_is_playing == 1)
        if (user_start_game_menu_input < 3)
          puts "Player 1 go"
        else
          puts "Computer 1 go"
        end
      else
        if (user_start_game_menu_input == 2)
          puts "Player 2 go"
        elsif (user_start_game_menu_input == 3)
          puts "Computer 2 go"
        else
          puts "Computer go"
        end
      end
      # Get the weapon from each player
      if (user_start_game_menu_input == 2 || (user_start_game_menu_input == 1 && who_is_playing == 1))
        players_weapon[who_is_playing-1] = menu($game_weapon,false)
        if (who_is_playing == 1)
          who_is_playing = 2
        elsif (who_is_playing == 2)
          who_is_playing = 0
        end
      else
        players_weapon[who_is_playing-1] = rand(1..$game_weapon.length)
        if (user_start_game_menu_input == 1)
          puts "Computer will use #{$game_weapon[players_weapon[who_is_playing-1]-1]}"
        else
          puts "Computer #{who_is_playing} will use #{$game_weapon[players_weapon[who_is_playing-1]-1]}"
        end
        if (who_is_playing == 1)
          who_is_playing = 2
        elsif (who_is_playing == 2)
          who_is_playing = 0
        end
      end
      puts ""
      # End of game / say who win
      if (who_is_playing == 0)
        who_win_is = who_win(players_weapon[0],players_weapon[1])
        if (who_win_is == 1)
          players_win[who_win_is-1] += 1
          if (user_start_game_menu_input < 3)
            puts "Player 1 wins"
          else
            puts "Computer 1 wins"
          end
        elsif (who_win_is == 2)
          players_win[who_win_is-1] += 1
          if (user_start_game_menu_input == 2)
            puts "Player 2 wins"
          elsif (user_start_game_menu_input == 3)
            puts "Computer 2 wins"
          else
            puts "Computer wins"
          end
        else
          players_win[2] += 1
          puts "Tie"
        end
        puts ""

        who_is_playing = menu(["Play again"], true)
        if (who_is_playing == 2)
          who_is_playing = 0
          # say how many win loss and tie
          if (user_start_menu_input == 1)
            puts "Player win is #{players_win[0]}"
            puts "Computer win is #{players_win[1]}"
            puts "Tie's is #{players_win[2]}"
          elsif (user_start_menu_input == 2)
            puts "Player 1 win is #{players_win[0]}"
            puts "PLayer 2 win is #{players_win[1]}"
            puts "Tie's is #{players_win[2]}"
          elsif (user_start_menu_input == 3)
            puts "Computer 1 win is #{players_win[0]}"
            puts "Computer 2 win is #{players_win[1]}"
            puts "Tie's is #{players_win[2]}"
          end
          print "press enter to continue"
          gets
          puts ""
        end
      end
    end
  # Option 2
  elsif (user_start_menu_input == 2)
    # if using R.P.S.
    if ($game_weapon.length == 3)
      $game_weapon = ["Rock","Paper","Scissors","Lizard","Spock"]
      puts "Sheldon game on"
    # if using Sheldon R.P.S.
    elsif ($game_weapon == 5)
      $game_weapon = ["Rock","Paper","Scissors"]
      puts "Sheldon game off"
    end
    print "press enter to continue"
    gets
  # Option 3
  elsif (user_start_menu_input == 3)
    puts "Each player are able to pick from Rock, Paper, or Scissors"
    print "press enter to continue"
    gets
    puts "With each option pick one of these will happen"
    puts "************************"
    puts "* Rock beats Scissors  *"
    puts "* Scissors beats paper *"
    puts "* Paper beats Rock     *"
    puts "************************"
    user_info_menu_input = menu(["Learn about Sheldon Rock, Paper, Scissors"],true)
    if (user_info_menu_input == 1)
      puts "*******************************"
      puts "* Scissors cuts paper         *"
      puts "* Paper covers rock           *"
      puts "* Rock crushes lizard         *"
      puts "* Lizard poisons Spock        *"
      puts "* Spock smashes scissors      *"
      puts "* Scissors decapitates lizard *"
      puts "* Lizard eats paper           *"
      puts "* Paper disproves Spock       *"
      puts "* Spock vaporizes Rock        *"
      puts "* Rock crushes scissors       *"
      puts "*******************************"
      print "press enter to continue"
      gets
    end
  else
    run_program = false
  end
end
