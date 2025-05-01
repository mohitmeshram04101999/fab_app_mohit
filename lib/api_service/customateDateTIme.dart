
class MyFormate
{

  String? formateDateTIme(DateTime? dateTime)
  {
    if(dateTime==null)
      {
        return null;
      }
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

}