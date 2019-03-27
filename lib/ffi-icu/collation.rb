module ICU
  module Collation

    def self.collate(locale, arr)
      Collator.new(locale).collate(arr)
    end

    def self.keywords
      enum_ptr = Lib.check_error { |error| Lib.ucol_getKeywords(error) }
      keywords = Lib.enum_ptr_to_array(enum_ptr)
      Lib.uenum_close enum_ptr

      hash = {}
      keywords.each do |keyword|
        enum_ptr = Lib.check_error { |error| Lib.ucol_getKeywordValues(keyword, error) }
        hash[keyword] = Lib.enum_ptr_to_array(enum_ptr)
        Lib.uenum_close(enum_ptr)
      end

      hash
    end

    def self.available_locales
      (0...Lib.ucol_countAvailable).map do |idx|
        Lib.ucol_getAvailable idx
      end
    end

    class Collator
      ULOC_VALID_LOCALE = 1
      UCOL_DEFAULT = -1
      UCOL_ON = 17
      UCOL_PRIMARY = 0

      def initialize(locale)
        if locale == "bo"
          bo_rules = File.read(File.join(__dir__, "/collation_rules/bo_rules.txt"))
          self.set_rules(bo_rules)
        else
          ptr = Lib.check_error { |error| Lib.ucol_open(locale, error) }
          @c = FFI::AutoPointer.new(ptr, Lib.method(:ucol_close))
        end
      end

      def locale
        Lib.check_error { |error| Lib.ucol_getLocale(@c, ULOC_VALID_LOCALE, error) }
      end

      def compare(a, b)
        Lib.ucol_strcoll(
          @c,
          UCharPointer.from_string(a), a.jlength,
          UCharPointer.from_string(b), b.jlength
        )
      end

      def greater?(a, b)
        Lib.ucol_greater(@c, UCharPointer.from_string(a), a.jlength,
                             UCharPointer.from_string(b), b.jlength)
      end

      def greater_or_equal?(a, b)
        Lib.ucol_greaterOrEqual(@c, UCharPointer.from_string(a), a.jlength,
                                    UCharPointer.from_string(b), b.jlength)
      end

      def equal?(*args)
        return super() if args.empty?

        if args.size != 2
          raise ArgumentError, "wrong number of arguments (#{args.size} for 2)"
        end

        a, b = args

        Lib.ucol_equal(@c, UCharPointer.from_string(a), a.jlength,
                           UCharPointer.from_string(b), b.jlength)
      end

      def collate(sortable)
        unless sortable.respond_to?(:sort)
          raise ArgumentError, "argument must respond to :sort with arity of 2"
        end

        sortable.sort { |a, b| compare a, b }
      end

      def rules
        @rules ||= begin
          length = FFI::MemoryPointer.new(:int)
          ptr = ICU::Lib.ucol_getRules(@c, length)
          ptr.read_array_of_uint16(length.read_int).pack("U*")
        end
      end

      def set_rules(string)
        ptr = Lib.check_error { |error| ICU::Lib.ucol_openRules(UCharPointer.from_string(string),string.jlength, UCOL_ON, UCOL_PRIMARY, nil, error) }
        @c = FFI::AutoPointer.new(ptr, Lib.method(:ucol_close))
      end
    end # Collator

  end # Collate
end # ICU
