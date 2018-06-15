require "open3"

module Commands
    def Commands.processes(user, key, order)
        command = (user.nil? || user.empty?) ? "ps -e u" : "ps -u #{user} u"
        processes_raw, status = Open3.capture2e(command)
        processes_rows = processes_raw.split("\n")
        columns = 11
        processes = processes_rows.map do |line| 
            cells = line.split(" ", columns)
            {
                user:       cells[0],
                pid:        cells[1],
                cpu:        cells[2],
                mem:        cells[3],
                vsz:        cells[4],
                rss:        cells[5],
                tty:        cells[6],
                stat:       cells[7],
                start:      cells[8],
                time:       cells[9],
                commmand:   cells[10]
            }
        end
        if key
            processes.sort_by! { |x| x[key.to_sym] }
            if order
                processes.reverse! if order == "desc"
            end
        end
        processes
    end
end
