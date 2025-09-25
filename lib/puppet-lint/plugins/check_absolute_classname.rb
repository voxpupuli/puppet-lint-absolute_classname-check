PuppetLint.new_check(:relative_classname_inclusion) do
  def check
    message = 'class included by absolute name (::$class)'

    tokens.each_with_index do |token, _token_idx|
      if %i[NAME FUNCTION_NAME].include?(token.type) && %w[include contain require].include?(token.value)
        s = token.next_code_token
        next if s.nil?
        next if s.type == :FARROW

        in_function = 0
        while s.type != :NEWLINE
          n = s.next_code_token
          if %i[NAME FUNCTION_NAME SSTRING].include?(s.type)
            if n && n.type == :LPAREN
              in_function += 1
            elsif in_function > 0 && n && n.type == :RPAREN
              in_function -= 1
            elsif in_function.zero? && s.value.start_with?('::')
              notify :warning, {
                message: message,
                line: s.line,
                column: s.column,
                token: s,
              }
            end
          end
          s = s.next_token
        end
      elsif token.type == :CLASS and token.next_code_token.type == :LBRACE
        s = token.next_code_token
        while s.type != :COLON
          if %i[NAME SSTRING].include?(s.type) && s.value.start_with?('::')
            notify :warning, {
              message: message,
              line: s.line,
              column: s.column,
              token: s,
            }
          end
          s = s.next_token
        end
      elsif token.type == :INHERITS
        s = token.next_code_token
        if s.type == :NAME && s.value.start_with?('::')
          notify :warning, {
            message: message,
            line: s.line,
            column: s.column,
            token: s,
          }
        end
      end
    end
  end

  def fix(problem)
    problem[:token].value = problem[:token].value[2..-1]
  end
end
