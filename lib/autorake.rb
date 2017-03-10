require 'ceedling/plugin'
require 'ceedling/constants'
require 'watch'

class Autorake < Plugin
    attr_reader :config

    def load configFilePath
        @configFilePath = configFilePath || @plugin_root + "/config/autorake.yml"
        @config = YAML.load_file(@configFilePath)
        run
    end

    def setup
        @plugin_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
    end

    def run
        addWatches makePaths
    end

    def addWatches(pathList)
        Watch.new(pathList) {
            sleep AUTORAKE_DELAY_TIME
            runTests
        }
    end

    def runTests
        system "rake " + AUTORAKE_TEST_COMMAND
    end

    def makePaths()
        pathList = "./{"
        @config[:autorake][:paths].each do |folder|
            pathList += folder + ","
        end
        pathList += "}/*"
    end
end