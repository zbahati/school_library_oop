require 'rspec'
require_relative '../person_class'

describe Person do
  let(:person) { Person.new(25, 'John', parent_permission: true) }

  it 'has an age' do
    expect(person.age).to eq(25)
  end

  it 'has a name' do
    expect(person.name).to eq('John')
  end

  it 'has an ID' do
    expect(person.id).to be_an(Integer)
  end

  it 'can use services if of age' do
    expect(person.can_use_services?).to be(true)
  end

  it 'can use services with parent permission' do
    person = Person.new(15, 'John', parent_permission: true)
    expect(person.can_use_services?).to be(true)
  end

  it 'cannot use services without parent permission or being of age' do
    person = Person.new(15, 'John', parent_permission: false)
    expect(person.can_use_services?).to be(false)
  end

  it 'generates JSON representation' do
    json_data = person.to_json
    expect(json_data).to be_a(Hash)
    expect(json_data[:age]).to eq(25)
    expect(json_data[:name]).to eq('John')
    expect(json_data[:parent_permission]).to be(true)
    expect(json_data[:id]).to be_an(Integer)
  end

  it 'parses JSON data into a Person object' do
    json_data = {
      'age' => 25,
      'name' => 'John',
      'parent_permission' => true,
      'id' => 123
    }

    parsed_person = Person.from_json(json_data)
    expect(parsed_person).to be_a(Person)
    expect(parsed_person.age).to eq(25)
    expect(parsed_person.name).to eq('John')
    expect(parsed_person.can_use_services?).to be(true)
    expect(parsed_person.id).to eq(123)
  end
end
