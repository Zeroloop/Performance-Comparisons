<?lasso

content_type('text/plain')

// Simple timer
define timethis(what::string) => {
	local(gb) = givenblock
	return '\n' + #what + '\t' + ((timer(1) => {#gb()})->get(2)->value * 0.001) +'\tmilliseconds\n\n'
}


protect => {
	handle_error => {
		// Execute capture x many times
		define do(count::integer,i::integer=0) => {
			local(gb) = givenblock
			not #count ? returnhome 
			{   #gb->invoke(++#i)
				#i < #count ? currentcapture->restart()
			}()
		}	
		// Fibonacci capture x many times
		define fibonacci(n::integer) => {
			#n < 1 ? return 0 
			local(
				swap = 0,
				n1 = 0,
				n2 = 1
			)

			do(#n) => {
				#swap = #n1 + #n2
				#n2   = #n1
				#n1   = #swap
			}

			return #n1
		}
		// Count instances of a pattern
		define string->count2(p::string) => {
			local(i=0,offset = 0)
			{
				#offset =  .find(#p,#offset != 0 ? #offset + #p->size | 1 )
				#offset == 0 ? returnhome
				#i++
				currentcapture->restart()
			}()
			return #i
		}
	}
	do(1)
	''->count('')
}

timethis('Fibonacci Numbers') => {^
	local(out) = ''
	do(40) => {
		#out->append(fibonacci(#1-1));
	}
	#out
^}

timethis('1,000,000') => {
    local(i) = 0
    {++#i != 1000000 ? currentcapture->restart}()
}
 
timethis('JSON') => {^

local(j) = json_deserialize('[{"batters": {"batter": [{"id": "1001", "type": "Regular"}, {"id": "1002", "type": "Chocolate"}, {"id": "1003", "type": "Blueberry"}, {"id": "1004", "type": "Devil\'s Food"}]}, "id": "0001", "name": "Cake", "ppu": 0.550000, "topping": [{"id": "5001", "type": "None"}, {"id": "5002", "type": "Glazed"}, {"id": "5005", "type": "Sugar"}, {"id": "5007", "type": "Powdered Sugar"}, {"id": "5006", "type": "Chocolate with Sprinkles"}, {"id": "5003", "type": "Chocolate"}, {"id": "5004", "type": "Maple"}], "type": "donut"}, {"batters": {"batter": [{"id": "1001", "type": "Regular"}]}, "id": "0002", "name": "Raised", "ppu": 0.550000, "topping": [{"id": "5001", "type": "None"}, {"id": "5002", "type": "Glazed"}, {"id": "5005", "type": "Sugar"}, {"id": "5003", "type": "Chocolate"}, {"id": "5004", "type": "Maple"}], "type": "donut"}, {"batters": {"batter": [{"id": "1001", "type": "Regular"}, {"id": "1002", "type": "Chocolate"}]}, "id": "0003", "name": "Old Fashioned", "ppu": 0.550000, "topping": [{"id": "5001", "type": "None"}, {"id": "5002", "type": "Glazed"}, {"id": "5003", "type": "Chocolate"}, {"id": "5004", "type": "Maple"}], "type": "donut"}]')

json_serialize(#j)

^}



timethis('Count String') => {
	'the three truths'->count('th')
	'ababababab'->count('abab')
}
 


// Using mysql.help_topic table

timethis('MySQL Inline') => {
    local(out) = '' 
    inline(
        -database = 'mysql', 
        -sql = 'SELECT name, example, url FROM help_topic LIMIT 0,100'
    ) => {
        rows => {
            #out->append(
              column('name')+', '+column('example')+' is here ' + column('url')
            )
        }
    }
}

// Download here: http://www.github.com/zeroloop/ds

timethis('MySQL Datasource') => {
    local(out) = '' 
    with row in ds(::mysqlds,'127.0.0.1',::mysql,'root','')->sql(
        'SELECT name, example, url FROM help_topic LIMIT 0,100'
    )->rows do {
        #out->append(
            #row(::name) + ', ' + #row(::example)+' is here ' + #row(::url) + '\n'
        )
    }
}


?>