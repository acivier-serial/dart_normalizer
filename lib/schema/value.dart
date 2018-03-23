import 'package:dart_normalizer/Pair.dart';
import 'package:dart_normalizer/schema/polymorfic.dart';

class  Values extends PolymorphicSchema {
  Values(definition, {schemaAttribute}) : super(definition, schemaAttribute);

  normalize(Map input, parent, String key, visit, addEntity) {
    Map<dynamic, dynamic> object ={};
    input.forEach((key, value){
      if(value != null) {
        object[key] = value;
      }
    });
    object.addAll(object.map((key, value)=> MapEntry(key, normalizeValue(value, input, key, visit, addEntity)) ));

    return object;

  }

  denormalize( input, unvisit) {
    print("denorm$input");
    return input.map((key, value) => MapEntry(key, denormalizeValue(value, unvisit)));
    return (input.keys).reduce((output, key)  {
        var entityOrId = input[key];
        return {
        output:denormalizeValue(entityOrId, unvisit),
        key: denormalizeValue(entityOrId, unvisit)
        };
    });
  }
}

