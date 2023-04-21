PuppetLint.new_check(:relative_classname_reference) do
  def check
    message = 'absolute class name reference'

    tokens.each_with_index do |token, _token_idx|
      next unless token.type == :TYPE and token.value == 'Class' and token.next_code_token.type == :LBRACK

      s = token.next_code_token
      while s.type != :RBRACK
        if (s.type == :NAME || s.type == :SSTRING) && s.value.start_with?('::')
          notify :warning, {
            message: message,
            line: s.line,
            column: s.column,
            token: s,
          }
        end
        s = s.next_token
      end
    end
  end

  def fix(problem)
    problem[:token].value = problem[:token].value[2..-1]
  end
end
