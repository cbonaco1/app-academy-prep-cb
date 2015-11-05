require_relative 'course'
require_relative 'student'

student1 = Student.new("Johnny", "Rocket")
student2 = Student.new("Johnny", "Drama")
student3 = Student.new("Otto", "Rocket")

course_one = Course.new("Ruby 101", "CS", 4)
course_two = Course.new("Python 101", "CS", 4)
course_three = Course.new("Calc", "MATH", 4)
course_four = Course.new("Geometry", "MATH", 4)
course_five = Course.new("Test", "CS", 2)

student1.enroll(course_one)
student1.enroll(course_two)

student1.enroll(course_three)
student1.enroll(course_three)
student1.enroll(course_three)
student1.enroll(course_three)

student1.enroll(course_four)
student1.enroll(course_five)

#student2.enroll(course_one)
#student3.enroll(course_one)
#student3.enroll(course_two)

student1.courses.each do |course|
	puts "student1 enrolled in #{course.name}"
end
#p "Courses: #{student1.courses}"