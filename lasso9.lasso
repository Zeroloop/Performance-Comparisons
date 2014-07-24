<?lasso

content_type('text/plain')

// Simple timer
define timethis(what::string) => {
	local(gb) = givenblock
	return '\n' + #what + '\t' + ((timer(1) => {#gb()})->get(2)->value * 0.001) +'\tmilliseconds\n\n'
}

// Execute capture x many times
define do(count::integer,i::integer=0) => {
	local(gb) = givenblock
	not #count ? returnhome 
	{   #gb->invoke(++#i)
		#i < #count ? currentcapture->restart()
	}()
}


define_tag("fibonacci", -required = "n", -type="integer");
	if(#n < 1);
		return 0;
	/if;
	local("swap") = 0;
	local("n1") = 0;
	local("n2") = 1;
	loop(#n);
		#swap = #n1 + #n2;
		#n2 = #n1;
		#n1 = #swap;
	/loop;
	return(#n1);
/define_tag;


define fibonacci2(n::integer) => {
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

timethis('Fibonacci Numbers: Old Code') => {^
	loop(-from=0, -to=39);
		fibonacci(loop_count);
	/loop; 
^} 

timethis('Fibonacci Numbers: Modern Code') => {^
	local(out) = ''
	with i in 0 to 39 do => {
		#out->append(fibonacci2(#i));
	}
	#out
^}


timethis('1,000,000: Loop') => {
	local(i) = 0
    loop(-from=0, -to=1000000) => { }
}

// array((micros = 514716.000000), (micros_average = 514716.000000))

timethis('1,000,000: Do') => {
	do(1000000) => {}
    //#out
}

timethis('1,000,000: Raw') => {
    local(i) = 0
    {++#i != 1000000 ? currentcapture->restart}()
}

'\n'
 
timethis('JSON') => {

local(j) = json_deserialize('[ { "id": "0001", "type": "donut", "name": "Cake", "ppu": 0.55, "batters": { "batter": [ { "id": "1001", "type": "Regular" }, { "id": "1002", "type": "Chocolate" }, { "id": "1003", "type": "Blueberry" }, { "id": "1004", "type": "Devil\'s Food" } ] }, "topping": [ { "id": "5001", "type": "None" }, { "id": "5002", "type": "Glazed" }, { "id": "5005", "type": "Sugar" }, { "id": "5007", "type": "Powdered Sugar" }, { "id": "5006", "type": "Chocolate with Sprinkles" }, { "id": "5003", "type": "Chocolate" }, { "id": "5004", "type": "Maple" } ] }, { "id": "0002", "type": "donut", "name": "Raised", "ppu": 0.55, "batters": { "batter": [ { "id": "1001", "type": "Regular" } ] }, "topping": [ { "id": "5001", "type": "None" }, { "id": "5002", "type": "Glazed" }, { "id": "5005", "type": "Sugar" }, { "id": "5003", "type": "Chocolate" }, { "id": "5004", "type": "Maple" } ] }, { "id": "0003", "type": "donut", "name": "Old Fashioned", "ppu": 0.55, "batters": { "batter": [ { "id": "1001", "type": "Regular" }, { "id": "1002", "type": "Chocolate" } ] }, "topping": [ { "id": "5001", "type": "None" }, { "id": "5002", "type": "Glazed" }, { "id": "5003", "type": "Chocolate" }, { "id": "5004", "type": "Maple" } ] }]')

json_serialize(#j)

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

timethis('MySQL DS') => {
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