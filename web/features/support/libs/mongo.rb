require "mongo"

Mongo::Logger.logger = Logger.new("./logs/mongo.log")

class MongoDB

    attr_accessor :users, :equipos

    def initialize 
        client = Mongo::Client.new(CONFIG["mongo"]) 
        @users = client[:users]
        @equipos = client[:equipos]
    end 

    def remover_usuario(email)
        @users.delete_many({email: email})
    end 

    def get_user(email)
        user = @users.find({email: email}).first
        return user [:_id]
    end

    def remover_equipamento(name, email)
        user_id = get_user(email)
        @equipos.delete_many({name: name, user: user_id})
    end 
end
