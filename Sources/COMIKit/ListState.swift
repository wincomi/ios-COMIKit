public enum ListState<Section, Failure> where Section: SectionRepresentable, Failure: Error {
	case loading
	case error(Failure)
	case loaded([Section])
}
