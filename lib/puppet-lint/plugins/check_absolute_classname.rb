PuppetLint.new_check(:relative_classname_inclusion) do
  def check
    tokens.each_with_index do |token, token_idx|
      reverse = PuppetLint.configuration.absolute_classname_reverse || false
      if reverse
        pattern = '^(?!::)'
        message = 'class included by absolute name (::$class)'
      else
        pattern = '^::'
        message = 'class included by relative name'
      end
      if [:NAME,:FUNCTION_NAME].include?(token.type) && ['include','contain','require'].include?(token.value)
        s = token.next_code_token
        next if s.nil?
        next if s.type == :FARROW

        in_function = 0
        while s.type != :NEWLINE
          n = s.next_code_token
          if [:NAME, :FUNCTION_NAME, :SSTRING,].include?(s.type)
            if n && n.type == :LPAREN
              in_function += 1
            elsif in_function > 0 && n && n.type == :RPAREN
              in_function -= 1
            elsif in_function.zero? && s.value !~ /#{pattern}/
              notify :warning, {
                message: message,
                line: s.line,
                column: s.column,
                token: s
              }
            end
          end
          s = s.next_token
        end
      elsif token.type == :CLASS and token.next_code_token.type == :LBRACE
        s = token.next_code_token
        while s.type != :COLON
          if (s.type == :NAME || s.type == :SSTRING) && s.value !~ /#{pattern}/
            notify :warning, {
              message: message,
              line: s.line,
              column: s.column,
              token: s
            }
          end
          s = s.next_token
        end
      end
    end
  end

  def fix(problem)
    reverse = PuppetLint.configuration.absolute_classname_reverse || false
    problem[:token].value = if reverse
                              problem[:token].value[2..-1]
                            else
                              '::' + problem[:token].value
                            end
  end
end
