PuppetLint.new_check(:relative_classname_inclusion) do
  def check
    tokens.each_with_index do |token, token_idx|
      if token.type == :NAME && token.value == 'include'
        s = token.next_code_token
        in_function = 0
        while s.type != :NEWLINE
          if s.type == :NAME || s.type == :SSTRING
            if s.next_code_token.type == :LPAREN
              in_function += 1
            elsif in_function > 0 && s.next_code_token.type == :RPAREN
              in_function -= 1
            elsif in_function == 0 && s.value !~ /^::/
              notify :warning, {
                :message => 'class included by relative name',
                :line    => s.line,
                :column  => s.column,
                :token   => s,
              }
            end
          end
          s = s.next_token
        end
      elsif token.type == :CLASS and token.next_code_token.type == :LBRACE
        s = token.next_code_token
        while s.type != :COLON
          if (s.type == :NAME || s.type == :SSTRING) && s.value !~ /^::/
            notify :warning, {
              :message => 'class included by relative name',
              :line    => s.line,
              :column  => s.column,
              :token   => s,
            }
          end
          s = s.next_token
        end
      end
    end
  end 

  def fix(problem)
    problem[:token].value = '::'+problem[:token].value
  end
end
