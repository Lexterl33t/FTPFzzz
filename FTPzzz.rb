=begin

Flemme decrire en anglais bienvenue dans cette nouvelle vidéo aujourd'hui nous allons développer un fuzzer FTP

FUZZER
    un fuzzer c'est un programme qui va tester la provenance de vulnerabilité en envoyant de la data dans un protocole ou encore dans un binaire afin
    de voir ce qui ce produit tout simplement alors on va simplement nous envoyer de la data donc un buffer mais nous verifierons pas si celui ci crash


[ CONCEPTION ]

    
=end

require 'colorize'
require 'open-uri'
require 'socket'

class Design

    def textAscii
        return open("http://artii.herokuapp.com/make?text=FTPZzz").read
    end

    def self.textAscii
        return open("http://artii.herokuapp.com/make?text=FTPZzz").read
    end

    def self.copy
        puts "[!] { Dev by Muham'RB }".red
        puts "[@] Github: https://github.com/MuhamRB".red
    end

end

class FTPFuzzer < TCPSocket

    @@ip = nil
    @@port = nil


    def initialize(ip, port=21)
        @@ip = ip
        @@port = port
    end


    def exploitation

        cmds_proto = ["RMDIR", "PWD", "USER", "PASS", "RMD", "RNFR"]

        count = 1

        #Creation d'un buffer avec un caractere dans le tableau
        buffer = ["B"]

        cmds_proto.each do |cmd|
            
            buffer.each do |bf|
                
                while buffer.length <= 70
                    buffer << buffer * count
                    count += 100
                end

                s = TCPSocket.new(@@ip, @@port)
                s.recv(4096)
                s.send "USER ftp\r\n", 0
                s.recv(4096)
                s.send("PASS ftp\r\n", 0)
                s.recv(4096)
                print "Sending #{cmd}\r"
                s.send cmd + " " + buf + "\r\n"
                s.recv(4096)
                s.close
            end
        end
    end
    
end

puts Design.textAscii.red
Design.copy

fuzz = FTPFuzzer.new("localhost", 21)
fuzz.exploitation