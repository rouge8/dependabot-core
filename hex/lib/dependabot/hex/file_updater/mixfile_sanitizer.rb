# frozen_string_literal: true

require "dependabot/hex/file_updater"
require "dependabot/shared_helpers"

module Dependabot
  module Hex
    class FileUpdater
      class MixfileSanitizer
        def initialize(mixfile_content:)
          @mixfile_content = mixfile_content
        end

        def sanitized_content
          mixfile_content.
            gsub(%r{String\.trim\(File\.read!\(.*?\)\)}, 'String.trim("0.0.1")').
            gsub(%r{String\.trim\(File\.read\(.*?\)\)}, 'String.trim({:ok, "0.0.1"})').
            gsub(/^\s*config_path:.*(?:,|$)/, "")
        end

        private

        attr_reader :mixfile_content
      end
    end
  end
end
