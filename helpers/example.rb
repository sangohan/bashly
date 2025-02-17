# A helper class used in Runfile to generate example README files
class Example
  class << self
    def dirs
      @dirs ||= Dir['examples/*'].select { |f| File.directory? f }
    end

    def all
      dirs.map { |dir| Example.new dir }
    end

    def executables
      all.map &:executable
    end
  end

  attr_reader :dir

  def initialize(dir)
    @dir = dir
  end

  def config
    @config ||= YAML.load_file(yaml_path)
  end

  def yaml
    @yaml ||= File.read(yaml_path).strip
  end

  def yaml_path
    "#{dir}/src/bashly.yml"
  end

  def readme_path
    "#{dir}/README.md"
  end

  def readme
    File.read readme_path
  end

  def test_commands
    filename = "#{dir}/test.sh"
    result = File.read(filename)
      .split(/\s*### Try Me ###\s*/).last
      .split("\n")
      .reject { |line| line.empty? or line.start_with? '#' }
    abort "Can't find ### Try Me ### marker in #{filename}" if result.empty?
    result
  end

  def test_output
    result = ''
    test_commands.each do |command|
      result += "### `$ #{command}`\n\n"
      result += "```shell\n"
      Dir.chdir dir do
        result += `#{command} 2>&1`
        result += "\n\n"
      end
      result += "```\n\n"
    end
    result
  end

  def regenerate_readme
    File.write readme_path, generated_readme
  end

  def generated_readme
    marker = '-----'
    content = readme.split(marker)[0].strip
    <<~EOF
    #{content}

    #{marker}

    ## `bashly.yml`

    ```yaml
    #{yaml}
    ```

    ## Generated script output

    #{test_output}

    EOF
  end

  def executable
    "#{dir}/#{config['name']}"
  end
end