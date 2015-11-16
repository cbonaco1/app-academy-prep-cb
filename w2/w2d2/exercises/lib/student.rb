# ## Student
# * `Student#initialize` should take a first and last name.
# * `Student#name` should return the concatenation of the student's
#   first and last name.
# * `Student#courses` should return a list of the `Course`s in which
#   the student is enrolled.
# * `Student#enroll` should take a `Course` object, add it to the
#   student's list of courses, and update the `Course`'s list of
#   enrolled students.
#     * `enroll` should ignore attempts to re-enroll a student.
# * `Student#course_load` should return a hash of departments to # of
#   credits the student is taking in that department.
#
require_relative 'course'
class Student
	attr_accessor :name, :first_name, :last_name, :courses
	
	def initialize(first_name, last_name)
		@name = "#{first_name} #{last_name}"
		@first_name = first_name
		@last_name = last_name
		@courses = []
	end

	#Take a Course object and add it to the Student's courses,
	#and update Course's list of enrolled Students
	#Should ignore attempts to re-enroll students 
	#(if a Student is already enrolled in a course, then do nothing)
	def enroll(course)
		unless @courses.include?(course)
			@courses.push(course) 
			course.students << self
		else
			puts "Student already enrolled"
		end
	end

	#return a hash of departments to # of
	#credits the student is taking in that department.
	def course_load
		student_course_load = Hash.new(0)
		courses.each do |course|
			student_course_load[course.department] += course.credits
		end
		student_course_load
	end
end