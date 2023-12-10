class Message {
  final String message;
  final DateTime date;
  final String uid;

  Message({required this.message, required this.date, required this.uid});

  Map<String,dynamic> convertToMap(){
  return {
   
    "uid":uid,
    "message":message,
    "date":date,
    
  };
}

}


