function split(s)
    delimiter = ","
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function convert_log_line(log_line)
    local fields = split(log_line)
    
    if #fields < 3 then
        return "failed field detect"
    end

    local timestamp = fields[3]
    -- remove timestamp from output text
    table.remove(fields,3)
    -- remove pulse duration from output text
    table.remove(fields,3)
    local text = table.concat(fields, " ")

    local parts = {}
    for part in string.gmatch(timestamp, '[^- :T%+]+') do
        parts[#parts + 1] = part
    end

    if #parts ~= 8 then
        return "failed parse time"
    end

    local seconds = tonumber(parts[6])
    local sec = math.floor(seconds)
    local msec = math.tointeger(math.floor((seconds - sec) * 1000))
    local time = os.time({
        year = tonumber(parts[1]),
        month = tonumber(parts[2]),
        day = tonumber(parts[3]),
        hour = tonumber(parts[4]),
        min = tonumber(parts[5]),
        sec = sec,
    })

    timestamp = time + (msec/1000)
    return text, timestamp
end

function convert_description()
    return "Converts Saleae logic decoder CSV output containing messages with timestamp format: 2022-04-17T04:44:54.061452850+00:00"
end

-- Test code for running 'lua saleae.lua' from terminal
-- text, timestamp = convert_log_line("\"SPI\",\"result\",2022-04-17T04:08:22.103108950+00:00,1.95e-06,0xFF,0x72")
-- print(text, timestamp)

