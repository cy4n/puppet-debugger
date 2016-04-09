module PuppetRepl
  module Support
    module InputResponders
      def help
        PuppetRepl::Cli.print_repl_desc
      end

      def facts
        # convert symbols to keys
        vars = node.facts.values
        ap(vars, {:sort_keys => true, :indent => -1})
      end

      def functions
        puts function_map.keys.sort
      end

      def vars
        # remove duplicate variables that are also in the facts hash
        vars = scope.to_hash.delete_if {| key, value | node.facts.values.key?(key) }
        vars['facts'] = 'removed by the puppet-repl' if vars.key?('facts')
        ap 'Facts were removed for easier viewing'
        ap(vars, {:sort_keys => true, :indent => -1})
      end

      def environment
        puts "Puppet Environment: #{puppet_env_name}"
      end

      def exit
        exit 0
      end

      def reset
        set_scope(nil)
        # initilize scope again
        scope
        set_log_level(log_level)
      end

      def krt
        ap(known_resource_types, {:sort_keys => true, :indent => -1})
      end

      def resources
        ap scope.compiler.resources
      end

      def classes

      end

    end
  end
end
