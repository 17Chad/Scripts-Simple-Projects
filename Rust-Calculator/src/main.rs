use clap::{App, Arg};

fn main() {
    let matches = App::new("Calculator")
        .version("1.0")
        .author("Your Name")
        .about("A simple calculator")
        .arg(Arg::with_name("operation")
            .short("o")
            .long("operation")
            .value_name("OPERATION")
            .help("Math operation to perform (+, -, *, /)")
            .required(true)
            .takes_value(true))
        .arg(Arg::with_name("operand1")
            .help("First operand")
            .required(true)
            .index(1))
        .arg(Arg::with_name("operand2")
            .help("Second operand")
            .required(true)
            .index(2))
        .get_matches();

    let operation = matches.value_of("operation").unwrap();
    let operand1: f64 = matches.value_of("operand1").unwrap().parse().unwrap();
    let operand2: f64 = matches.value_of("operand2").unwrap().parse().unwrap();

    let result = match operation {
        "+" => operand1 + operand2,
        "-" => operand1 - operand2,
        "*" => operand1 * operand2,
        "/" => {
            if operand2 != 0.0 {
                operand1 / operand2
            } else {
                println!("Division by zero is not allowed.");
                return;
            }
        }
        _ => {
            println!("Invalid operation. Supported operations: +, -, *, /");
            return;
        }
    };

    println!("Result: {}", result);
}

