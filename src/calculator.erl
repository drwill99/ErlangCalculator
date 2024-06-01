-module(calculator).
-export([start/0]).
  
% This module implements a simple interactive calculator that maintains a running total. 
% The calculator supports operations for addition, subtraction, multiplication, division,
% exponentiation, displaying the current total, and clearing the total. The user can 
% quit the calculator by entering the command 'q'.

% The calculate function runs recursively, processing user inputs to update the subtotal
% until the user decides to quit by entering 'q'.

calculate(I, Sub) ->
    % Check if the input is empty. If so, prompt the user for valid input again.
    if
        length(I) < 1 -> calculate(lists:delete(10, io:get_line("Invalid value, please enter a valid command: ")), Sub);
        
        % If input is not empty, split it into command and number.
        length(I) > 0 ->
            % Split the input string into a command and number.
            X = lists:split(1, I),
            Command = element(1, X),  % Command is the first character.
            Number = element(1, string:to_integer(element(2, X))),  % Convert the remaining part to an integer.
            
            % Process the command using pattern matching and a case statement.
            case Command of
                % If the command is 'q', print the final total and exit.
                "q" ->
                    io:format("Total = ~w~n", [Sub]),
                    io:format("Thank you for using the Erlang Calculator!~n");

                % If the command is 'a' (addition), add the number to the subtotal.
                "a" ->
                    io:format("~w + ~w = ~w~n", [Sub, Number, Sub + Number]),
                    calculate(lists:delete(10, io:get_line("Enter a command: ")), Sub + Number);

                % If the command is 's' (subtraction), subtract the number from the subtotal.
                "s" ->
                    io:format("~w - ~w = ~w~n", [Sub, Number, Sub - Number]),
                    calculate(lists:delete(10, io:get_line("Enter a command: ")), Sub - Number);

                % If the command is 'm' (multiplication), multiply the subtotal by the number.
                "m" ->
                    io:format("~w * ~w = ~w~n", [Sub, Number, Sub * Number]),
                    calculate(lists:delete(10, io:get_line("Enter a command: ")), Sub * Number);

                % If the command is 'd' (division), divide the subtotal by the number, handling division by zero.
                "d" ->
                    case Number of
                        0 ->
                            io:format("Cannot divide by zero!~n"),
                            calculate(lists:delete(10, io:get_line("Enter a command: ")), Sub);
                        _ ->
                            io:format("~w / ~w = ~w~n", [Sub, Number, Sub / Number]),
                            calculate(lists:delete(10, io:get_line("Enter a command: ")), Sub / Number)
                    end;

                % If the command is 'e' (exponentiation), raise the subtotal to the power of the number.
                "e" ->
                    io:format("~w ^ ~w = ~w~n", [Sub, Number, math:pow(Sub, Number)]),
                    calculate(lists:delete(10, io:get_line("Enter a command: ")), math:pow(Sub, Number));

                % If the command is 't' (total), display the current subtotal.
                "t" ->
                    io:format("Subtotal = ~w~n", [Sub]),
                    calculate(lists:delete(10, io:get_line("Enter a command: ")), Sub);

                % If the command is 'c' (clear), reset the subtotal to 0.
                "c" ->
                    io:format("Subtotal cleared to 0~n"),
                    calculate(lists:delete(10, io:get_line("Enter a command: ")), 0);

                % If the command is unrecognized, prompt the user for valid input again.
                _ ->
                    calculate(lists:delete(10, io:get_line("Invalid command, please enter a valid command: ")), Sub)
            end
    end.

% The start function initializes the calculator. It displays a welcome message and instructions,
% then calls the calculate function with an initial subtotal of 0 and prompts the user for the first input.
start() ->
    io:format("Welcome to the Erlang Calculator!~nYou will start with the value of 0~n"),
    io:format("Keep entering commands until you would like to quit.~n"),
    io:format("A command is a letter for the operation, immediately followed by the number you wish to perform that operation on.~n"),
    io:format("The list of operations are as follows:~n'a' for addition~n's' for subtraction~n"),
    io:format("'m' for multiplication~n'd' for division~n'e' to raise the running total to the exponent you wish~n"),
    io:format("'t' to display the working total~n'c' to clear the working total back to 0~n"),
    io:format("'q' to quit and display the final total~n"),
    calculate(lists:delete(10, io:get_line("Enter a command: ")), 0).
