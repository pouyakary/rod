
#
# ─── GRAMMAR ────────────────────────────────────────────────────────────────────
#

    class Grammar
        def initialize ( code : String ): String | Nil
            # grammar sections
            grammar_parts = code.split( "---" )
            if grammar_parts.size != 2
                return "Could not find the grammar divider (---)"
            end
            grammar_head = grammar_parts[0].strip
            grammar_rules = grammar_parts[1].strip

            # rules
            lines = grammar_rules.split( "\n" )
            @rules = Array(Rule).new
            lines.each do | line |
                @rules.push(Rule.new( line ))
            end

            # header
            grammar_header_parts = grammar_head.split( ":::" )
            if grammar_header_parts.size != 2
                return "Could not find the hedare divider (:::)"
            end
            @switch_on = ""
            @switch_on = grammar_header_parts[0].strip
            @default_value = ""
            @default_value = grammar_header_parts[1].strip

            #
            return nil
        end

        def rules
            @rules
        end

        def switch_on
            @switch_on
        end

        def default_value
            @default_value
        end
    end

#
# ─── RULE ───────────────────────────────────────────────────────────────────────
#

    class Rule
        def initialize ( line : String )
            @condition = ""
            @value = ""
            language_parts = line.split( "==>" )
            if language_parts.size == 2
                @condition = language_parts[0].strip
                @value = language_parts[1].strip
            end
        end

        def generate_ternary ( case_on : String )
            "#{ case_on } #{ condition } ? "
        end

        def condition
            @condition
        end

        def value
            @value
        end
    end

#
# ─── GENERATE ───────────────────────────────────────────────────────────────────
#

    def generate ( grammar : Grammar, index : Int32 )
        if grammar.rules.size - 1 == index
            rule = grammar.rules[ index ]
            "(#{ grammar.switch_on } #{ rule.condition }) ? (#{ rule.value }) : (#{ grammar.default_value })"
        else
            rule = grammar.rules[ index ]
            rest = generate( grammar, index + 1 )
            "(#{ grammar.switch_on } #{ rule.condition }) ? (#{ rule.value }) : (#{ rest })"
        end
    end

#
# ─── MAIN ───────────────────────────────────────────────────────────────────────
#

    def get_file_address ( ): String
        file_name = ""
        if ARGV.size == 1
            ARGV.each_with_index do | arg, i |
                file_name = "#{ Dir.current }/#{ arg }"
            end
            return file_name
        else
            return ""
        end
    end

    def main ( )
        file_name = get_file_address( )
        if file_name == ""
            puts "Wrong argument number."
        else
            file = File.read file_name
            grammar = Grammar.new file
            generated_code = generate( grammar, 0 )
            puts(generated_code)
        end
    end

    main( )

# ────────────────────────────────────────────────────────────────────────────────
